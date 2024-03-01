//
//  Effect.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 28.02.24.
//

import Foundation
import CoreImage

extension ImageProcessingManager {
    
    enum Effect: Int {
        case mono
    }
    
    func setEffect(effect: Effect) {
        switch effect {
        case .mono:
            currentEffect = MonoEffect()
        }
    }
    
    func applyEffect(for image: CIImage) -> CIImage {
        
        guard let currentEffect else { return image }           // TODO: - handle error
        let filteredImage = currentEffect.apply(for: image)
        
        return filteredImage
    }
    
// MARK: - Effects
    final class MonoEffect: EffectProtocol {
        
        let filter: CIFilter! = CIFilter(name: "CIPhotoEffectNoir")
        
        func apply(for image: CIImage) -> CIImage {
            
            filter.setValue(image, forKey: kCIInputImageKey)
            
            guard let outputImage = filter.outputImage else { return image }
            return outputImage
        }
    }
}
