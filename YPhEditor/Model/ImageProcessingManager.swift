//
//  ImageProcessingManager.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 2.02.24.
//

import Foundation
import MetalKit

class ImageProcessingManager {
    
    static let shared = ImageProcessingManager()
    private init() { }
    
    let device: MTLDevice! = MTLCreateSystemDefaultDevice()
    
    func fitImage(_ image: CIImage, to view: MetalImageView) -> CIImage {
        
        let viewWidth = view.drawableSize.width
        let viewHeight = view.drawableSize.height
        
        let scaleX = viewWidth / image.extent.width
        let scaleY = viewHeight / image.extent.height
        let scale: CGFloat = max(scaleX, scaleY)
        
        let newImageWidth = image.extent.width * scale
        let newImageHeight = image.extent.height * scale
        let originX = (viewWidth - newImageWidth) / 2
        let originY = (viewHeight - newImageHeight) / 2
        
        let scaledImage = image
            .transformed(by: CGAffineTransform(scaleX: scale, y: scale))
            .transformed(by: CGAffineTransform(translationX: originX < 0 ? 0 : originX, y: originY < 0 ? 0 : originY))
        
        return scaledImage
    }
    
    // MARK: - FILTERS
    
    class MonoFilter: Filter {
        
        let filter: CIFilter! = CIFilter(name: "CIPhotoEffectNoir")
        
        func apply(for image: CIImage) -> CIImage {
            filter.setValue(image, forKey: kCIInputImageKey)
            guard let outputImage = filter.outputImage else { return image }
            return outputImage
        }
    }
}
