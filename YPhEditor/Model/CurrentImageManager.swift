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
        super.init()
        
        guard let imageProcessingData = CoreDataManager.shared.fetch(),
              let imageData = imageProcessingData.image,
              let uiImage = UIImage(data: imageData)
        else { return }                                                                 // TODO: - handle error

        currentUIImage = uiImage
        currentCIImage = CIImage(image: uiImage)
    }
    
    var currentUIImage: UIImage? {
        didSet {
            
            guard let currentUIImage else { return }                            // TODO: - handle error
            currentCIImage = CIImage(image: currentUIImage)
        }
    }
    
    var currentCIImage: CIImage?
    
    var currentCGImage: CGImage? {
        return currentUIImage?.cgImage
    }
    
    func saveImageToGallery() {
        guard let currentCIImage = ImageProcessingManager.shared.applyProcessingStack(for: currentCIImage),
              let cgImage = ImageProcessingManager.shared.ciContext.createCGImage(currentCIImage, from: currentCIImage.extent),
              let orientation = currentUIImage?.imageOrientation
        else { return }                                                                 //TODO: handle error и выводить ее на экран
        
        
        let imageToSave = UIImage(cgImage: cgImage, scale: 1, orientation: orientation)
        UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func uploadImage() {
        guard let ciImage = currentCIImage,
              let ciImage = ImageProcessingManager.shared.applyProcessingStack(for: ciImage),
              let cgImage = ImageProcessingManager.shared.ciContext.createCGImage(ciImage, from: ciImage.extent),
              let orientation = currentUIImage?.imageOrientation
        else { return }       //TODO: handle error
        
        NetworkManager.shared.uploadImage(UIImage(cgImage: cgImage, scale: 1, orientation: orientation))
    }
}

@objc extension CurrentImageManager {
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error {
            print(error)         //TODO: handle error
        }
    }
}
