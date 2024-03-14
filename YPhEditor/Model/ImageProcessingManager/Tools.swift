//
//  Transforms.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 28.02.24.
//

import Foundation
import UIKit

extension ImageProcessingManager {
    
    enum Tools {
        
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
        
        static func createQRFrom(_ value: String?) -> CIImage? {
            guard let value else { return Resources.Images.imageError.ciImage}
            let data = value.data(using: String.Encoding.ascii)
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 4, y: 4)
                
            let output = filter?.outputImage?.transformed(by: transform)
            return output
        }
        
        static func getMetadataFromImage(_ image: UIImage) -> [String: Any]? {
            guard let imageData = image.jpegData(compressionQuality: 1.0),
                  let source = CGImageSourceCreateWithData(imageData as CFData, nil),
                  let metaData = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [String: Any]
            else { return nil }
            
            return metaData
        }
        
        static func applyAESRNetFor(_ image: CGImage?) async -> CGImage? {
            MLManager.shared.AESRNetModelPredictFor(image)
        }
        
        static func applyPaprikaFor(_ image: CGImage?) async -> CGImage? {
            MLManager.shared.paprikaModelPredictFor(image)
        }
    }
}
