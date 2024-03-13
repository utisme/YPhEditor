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
        case without, noir, mono, instant, fade, chrome, invert, mask
        
        static func getEffectIndex(for effect: EffectProtocol) -> Int? {
            var allEffects: [EffectProtocol] = []
            Effect.allCases.forEach { effect in
                allEffects.append(effect.getEffect())
            }
            return allEffects.firstIndex { type(of: $0) == type(of: effect)}
        }
        
        func getEffect() -> EffectProtocol {
            
            switch self {
            case .without:
                WithoutEffect()
            case .noir:
                NoirEffect()
            case .mono:
                MonoEffect()
            case .instant:
                InstantEffect()
            case .fade:
                FadeEffect()
            case .chrome:
                ChromeEffect()
            case .invert:
                InvertEffect()
            case .mask:
                MaskEffect()
            }
        }
        
        // MARK: - Effects
        
        final class WithoutEffect: EffectProtocol {
            
            func apply(for image: CIImage?) -> CIImage? {
                image
            }
        }
        
        final class NoirEffect: EffectProtocol {
            
            let filter: CIFilter! = CIFilter(name: "CIPhotoEffectNoir")
            
            func apply(for image: CIImage?) -> CIImage? {
                
                filter.setValue(image, forKey: kCIInputImageKey)
                
                guard let outputImage = filter.outputImage else {
                    debugPrint(":: Error: ImageProcessingManager -> Adjust -> Effect -> apply(): Applying filter error")
                    return image
                }
                
                return outputImage
            }
        }
        
        final class MonoEffect: EffectProtocol {
            
            let filter: CIFilter! = CIFilter(name: "CIPhotoEffectMono")
            
            func apply(for image: CIImage?) -> CIImage? {
                
                filter.setValue(image, forKey: kCIInputImageKey)
                
                guard let outputImage = filter.outputImage else {
                    debugPrint(":: Error: ImageProcessingManager -> Adjust -> Effect -> apply(): Applying filter error")
                    return image
                }
                
                return outputImage
            }
        }
        
        final class InstantEffect: EffectProtocol {
            
            let filter: CIFilter! = CIFilter(name: "CIPhotoEffectInstant")
            
            func apply(for image: CIImage?) -> CIImage? {
                
                filter.setValue(image, forKey: kCIInputImageKey)
                
                guard let outputImage = filter.outputImage else {
                    debugPrint(":: Error: ImageProcessingManager -> Adjust -> Effect -> apply(): Applying filter error")
                    return image
                }
                
                return outputImage
            }
        }
        
        final class FadeEffect: EffectProtocol {
            
            let filter: CIFilter! = CIFilter(name: "CIPhotoEffectFade")
            
            func apply(for image: CIImage?) -> CIImage? {
                
                filter.setValue(image, forKey: kCIInputImageKey)
                
                guard let outputImage = filter.outputImage else {
                    debugPrint(":: Error: ImageProcessingManager -> Adjust -> Effect -> apply(): Applying filter error")
                    return image
                }
                
                return outputImage
            }
        }
        
        final class ChromeEffect: EffectProtocol {
            
            let filter: CIFilter! = CIFilter(name: "CIPhotoEffectChrome")
            
            func apply(for image: CIImage?) -> CIImage? {
                
                filter.setValue(image, forKey: kCIInputImageKey)
                
                guard let outputImage = filter.outputImage else {
                    debugPrint(":: Error: ImageProcessingManager -> Adjust -> Effect -> apply(): Applying filter error")
                    return image
                }
                
                return outputImage
            }
        }
        
        final class InvertEffect: EffectProtocol {
            
            let filter: CIFilter! = CIFilter(name: "CIColorInvert")
            
            func apply(for image: CIImage?) -> CIImage? {
                
                filter.setValue(image, forKey: kCIInputImageKey)
                
                guard let outputImage = filter.outputImage else {
                    debugPrint(":: Error: ImageProcessingManager -> Adjust -> Effect -> apply(): Applying filter error")
                    return image
                }
                
                return outputImage
            }
        }
        
        final class MaskEffect: EffectProtocol {
            
            let filter: CIFilter! = CIFilter(name: "CIMaskToAlpha")
            
            func apply(for image: CIImage?) -> CIImage? {
                
                filter.setValue(image, forKey: kCIInputImageKey)
                
                guard let outputImage = filter.outputImage else {
                    debugPrint(":: Error: ImageProcessingManager -> Adjust -> Effect -> apply(): Applying filter error")
                    return image
                }
                
                return outputImage
            }
        }
    }
}
