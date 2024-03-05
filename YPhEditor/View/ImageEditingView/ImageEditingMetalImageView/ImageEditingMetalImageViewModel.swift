//
//  ImageEditingMetalImageViewModel.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 22.02.24.
//

import Foundation
import UIKit
import CoreImage

final class ImageEditingMetalImageViewModel: ImageEditingMetalImageViewModelProtocol {
    
    func getCurrentImage() -> CGImage? {
        
        guard let image = CurrentImageManager.shared.currentCGImage
        else {
            return Resources.Images.imageError.cgImage
        }
        return image
    }
    
    func prepareImage(_ image: CIImage, to view: MetalImageView) -> CIImage {
        
        let scaledToViewImage = ImageProcessingManager.Transforms.fitImage(image, to: view, minScale: true)
        guard let processedImage = ImageProcessingManager.shared.applyProcessingStack(for: scaledToViewImage) else { return scaledToViewImage }         // TODO: handle error
        
        return processedImage
    }
}
