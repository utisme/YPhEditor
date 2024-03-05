//
//  CurrentImageManager.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 8.02.24.
//

import Foundation
import CoreImage
import UIKit

final class CurrentImageManager {
    
    static let shared = CurrentImageManager()
    private init() {
        
        guard let imageProcessingData = CoreDataManager.shared.fetch(),
              let imageData = imageProcessingData.currentImage,
              let uiImage = UIImage(data: imageData)
        else { return }                                                                 // TODO: - handle error
        
        currentUIImage = uiImage
        currentCIImage = CIImage(image: uiImage)
    }
    
    var currentUIImage: UIImage? {
        didSet {
            
            guard let currentUIImage else { return }                            // TODO: - handle error
            
            currentCIImage = CIImage(image: currentUIImage)
            
            CoreDataManager.shared.update { update in
                update.currentImage = currentUIImage.jpegData(compressionQuality: 0)
            }
        }
    }
    
    var currentCIImage: CIImage?
    
    var currentCGImage: CGImage? {
        return currentUIImage?.cgImage
    }
}
