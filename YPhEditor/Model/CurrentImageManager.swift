//
//  CurrentImageManager.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 8.02.24.
//

import Foundation
import CoreImage
import UIKit

final class CurrentImageManager: NSObject {
    
    static let shared = CurrentImageManager()
    override private init() {
        debugPrint(":: Initialization CurrentImageManager")
        super.init()
        
        guard let imageProcessingData = CoreDataManager.shared.fetch(),
              let imageData = imageProcessingData.image,
              let uiImage = UIImage(data: imageData)
        else {
            debugPrint(":: Error: CurrentImageManager -> init(): Loading from CoreData Error")
            return
        }

        currentUIImage = uiImage
        currentCIImage = CIImage(image: uiImage)
    }
    
    var currentUIImage: UIImage? {
        didSet {
            guard let currentUIImage else {
                debugPrint(":: Error: CurrentImageManager -> currentUIImage didSet: currentUIImage = nil")
                return
            }
            
            currentCIImage = CIImage(image: currentUIImage)
        }
    }
    
    var currentCIImage: CIImage?
    
    var currentCGImage: CGImage? {
        return currentUIImage?.cgImage
    }
    
//MARK: Export
    func saveImageToGallery() {
        guard let currentCIImage = ImageProcessingManager.shared.applyProcessingStack(for: currentCIImage),
              let cgImage = ImageProcessingManager.shared.ciContext.createCGImage(currentCIImage, from: currentCIImage.extent),
              let orientation = currentUIImage?.imageOrientation
        else { 
            debugPrint(":: Error: CurrentImageManager -> saveImageToGallery(): Saving to gallery error")
            return }                                                                 //TODO: выводить ошибку на экран
        
        
        let imageToSave = UIImage(cgImage: cgImage, scale: 1, orientation: orientation)
        UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func uploadImage() {
        guard let ciImage = currentCIImage,
              let ciImage = ImageProcessingManager.shared.applyProcessingStack(for: ciImage),
              let cgImage = ImageProcessingManager.shared.ciContext.createCGImage(ciImage, from: ciImage.extent),
              let orientation = currentUIImage?.imageOrientation
        else { 
            debugPrint(":: Error: CurrentImageManager -> uploadImage(): Uploading image error")
            return }
        
        NetworkManager.shared.uploadImage(UIImage(cgImage: cgImage, scale: 1, orientation: orientation))
    }
}

@objc extension CurrentImageManager {
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error {
            debugPrint(":: Error: CurrentImageManager -> image(): Saving to gallery \(error)")
        }
    }
}
