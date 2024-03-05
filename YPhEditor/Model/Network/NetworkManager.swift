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
    private init() {}
    
    private let host = "https://api.unsplash.com/"
    private let route = "photos/"
    private let params = "client_id=AQCJXXYQB-A_OIAAeAZ5EKccv7jT0RmemfYTUgthj8M"
    private let requestParams = ["order_by":"popular"]
    
    let imagesObservable = PublishRelay<[UIImage]>()
    var images: [UIImage] = []
    
    func prepareImages() {
        
        guard images.count == 0
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in                // TODO: - костыль
                guard let self else { return }
                imagesObservable.accept(images)
            }
            return
        }
        
        getImages { [weak self] in
            guard let self else { return }
            self.imagesObservable.accept(self.images)
        }
    }
    
    
    private func createURL() -> String {
        
        let url = host + route + "?" + params
        return url
    }
    
    private func getImages(completion: @escaping ()->()) {
        AF.request(createURL(), parameters: requestParams)
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
                    print(error)
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
                
                print(error)
                
            }
            completion()
        }
    }
}
