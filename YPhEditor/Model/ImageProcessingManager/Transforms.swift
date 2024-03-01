//
//  Transforms.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 28.02.24.
//

import Foundation
import CoreImage

extension ImageProcessingManager {
    
    enum Transforms {
        
        static func fitImage(_ image: CIImage, to view: MetalImageView, minScale: Bool = false) -> CIImage {
            
            let viewWidth = view.drawableSize.width
            let viewHeight = view.drawableSize.height
            
            let scaleX = viewWidth / image.extent.width
            let scaleY = viewHeight / image.extent.height
            var scale: CGFloat
            if minScale {
                scale = min(scaleX, scaleY)
            } else {
                scale = max(scaleX, scaleY)
            }
            
            let newImageWidth = image.extent.width * scale
            let newImageHeight = image.extent.height * scale
            let originX = (viewWidth - newImageWidth) / 2
            let originY = (viewHeight - newImageHeight) / 2
            
            let scaledImage = image
                .transformed(by: CGAffineTransform(scaleX: scale, y: scale))
                .transformed(by: CGAffineTransform(translationX: originX < 0 ? 0 : originX, y: originY < 0 ? 0 : originY))
            
            return scaledImage
        }
    }
}
