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
              let imageData = imageProcessingData.currentImage
        else { return }                                                                 // TODO: - handle error
        
        currentUIImage = UIImage(data: imageData)
    }
    
    var currentUIImage: UIImage? {
        didSet {
            
            guard let currentUIImage else { return }                            // TODO: - handle error
            
            CoreDataManager.shared.update { update in
                update.currentImage = currentUIImage.jpegData(compressionQuality: 0)
            }
        }
    }
    
    var currentCIImage: CIImage? {                              // TODO: доделать перезапись в currentUIImage
        get {
            guard let currentUIImage,
                  let ciImage = CIImage(image: currentUIImage)
            else { return Resources.Images.imageError.ciImage}             // TODO: - HANDLE ERROR
            
            return ImageProcessingManager.shared.applyProcessingStack(for: ciImage)
        }
    }
    
    var currentCGImage: CGImage? {
        return currentUIImage?.cgImage
    }
}
