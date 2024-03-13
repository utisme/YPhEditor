//
//  NetworkManager.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 7.02.24.
//

import Foundation
import RxRelay
import Alamofire
import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    private init() { debugPrint(":: Initialization NetworkManager") }
    
    private let imagesSource = "https://api.unsplash.com/photos/?client_id=AQCJXXYQB-A_OIAAeAZ5EKccv7jT0RmemfYTUgthj8M"
    private let getRequestParams = ["order_by":"popular"]
    let imagesObservable = PublishRelay<[UIImage]>()
    var images: [UIImage] = []
    
    private let imageHosting = "https://api.imgbb.com/1/upload?expiration=600&key=cd8130c5bc3bdcef2bc1d09e8ee3d585"
    let uploadObservable = PublishRelay<String>()
    
    
//MARK: Proposed images fetching
    func prepareImages() {
        
        guard images.count == 0
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in                // TODO: - костыль
                guard let self else { 
                    debugPrint(":: Error: NetworkManager -> prepareImages: Guard error")
                    return }
                
                imagesObservable.accept(images)
            }
            return
        }
        
        getImages { [weak self] in
            guard let self else { 
                debugPrint(":: Error: NetworkManager -> prepareImages: Guard error")
                return }
            
            self.imagesObservable.accept(self.images)
        }
    }
    
    private func getImages(completion: @escaping ()->()) {
        AF.request(imagesSource, parameters: getRequestParams)
            .validate()
            .responseDecodable(of: [ImageURLs].self) { [weak self] response in
                
                switch response.result {
                    
                case .success(let data):
                    let dispatchGroup = DispatchGroup()
                    data.forEach { [weak self] imageURL in
                        dispatchGroup.enter()
                        self?.fetchData(fromURL: imageURL.full) {
                            dispatchGroup.leave()
                        }
                    }
                    dispatchGroup.notify(queue: .main) {
                        completion()
                    }
                    
                case .failure(let error):
                    debugPrint(":: Error: NetworkManager -> getImages: \(error.localizedDescription)")
                }
                
            }
    }
    
    private func fetchData(fromURL url: String, completion: @escaping ()->()) {
        
        AF.request(url).responseData { [weak self] response in
            switch response.result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else {
                    completion()
                    return
                }
                self?.images.append(image)
                
            case .failure(let error):
                debugPrint(":: Error: NetworkManager -> fetchData: \(error.localizedDescription)")
            }
            completion()
        }
    }

//MARK: Image uploading
    func uploadImage(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            debugPrint(":: Error: NetworkManager -> uploadImage: JPEG data receiving error")
            return
        }             
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image.jpeg")
        }, to: imageHosting)
        .responseDecodable(of: HostedImageUrl.self) { [unowned self] response in
            switch response.result {
            case .success(let value):
                uploadObservable.accept(value.url)
            case .failure(let error):
                debugPrint(":: Error: NetworkManager -> uploadImage: \(error.localizedDescription)")
            }
        }
    }
}
