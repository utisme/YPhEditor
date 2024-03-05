//
//  Effect.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 28.02.24.
//

import Foundation
import UIKit

extension ImageProcessingManager.Adjust {
    
    enum Effect: Int, CaseIterable {
        case mono, invert, mask
        
        func getEffect() -> EffectProtocol {
            
            switch self {
            case .mono:
                MonoEffect()
            case .invert:
                InvertEffect()
            case .mask:
                MaskEffect()
            }
        }
        
        
        // MARK: - Effects
        final class MonoEffect: EffectProtocol {
            
            let filter: CIFilter! = CIFilter(name: "CIPhotoEffectNoir")
            let effectIcon: UIImage = Resources.Images.imageError
            
            func apply(for image: CIImage?) -> CIImage? {
                
                filter.setValue(image, forKey: kCIInputImageKey)
                
                guard let outputImage = filter.outputImage else { return image }
                return outputImage
            }
        }
        
        final class InvertEffect: EffectProtocol {
            
            let filter: CIFilter! = CIFilter(name: "CIColorInvert")
            let effectIcon: UIImage = Resources.Images.imageError
            
            func apply(for image: CIImage?) -> CIImage? {
                
                filter.setValue(image, forKey: kCIInputImageKey)
                
                guard let outputImage = filter.outputImage else { return image }
                return outputImage
            }
        }
        
        final class MaskEffect: EffectProtocol {
            
            let filter: CIFilter! = CIFilter(name: "CIMaskToAlpha")
            let effectIcon: UIImage = Resources.Images.imageError
            
            func apply(for image: CIImage?) -> CIImage? {
                
                filter.setValue(image, forKey: kCIInputImageKey)
                
                guard let outputImage = filter.outputImage else { return image }
                return outputImage
            }
        }
    }
}
