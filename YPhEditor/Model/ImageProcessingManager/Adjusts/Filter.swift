//
//  Filter.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 28.02.24.
//

import Foundation
import MetalKit
import RxRelay

extension ImageProcessingManager.Adjust {
    
    //TODO: РАССМОТРЕТЬ ЗДЕСЬ ПРИМЕНЕНИЕ ФАБРИКИ
    
    enum Filter: Int, CaseIterable {
        case exposure, gamma, saturation, contrast, brightness, vibrance, tint
        
        func getFilter() -> FilterProtocol {
            
            switch self {
            case .exposure:
                ExposureFilter()
            case .gamma:
                GammaFilter()
            case .saturation:
                SaturationFilter()
            case .contrast:
                ContrastFilter()
            case .brightness:
                BrightnessFilter()
            case .vibrance:
                VibranceFilter()
            case .tint:
                TintFilter()
            }
        }
        
        // MARK: - FILTERS
        
        final class ExposureFilter: FilterProtocol  {
            
            var ciFilter: CIFilter! = CIFilter(name: "CIExposureAdjust")
            private let valueKey = kCIInputEVKey
            var filterIcon: UIImage? = Resources.Images.ImageEditing.Filters.exposure
            
            private let sliderValueCoef: CGFloat = 0.05
            private let defaultValue: CGFloat = 0
            
            let minSliderValue: CGFloat = -100
            let maxSliderValue: CGFloat = 100
            var value: CGFloat = 0
            
            func apply(for image: CIImage?) -> CIImage? {
                ciFilter.setValue(value * sliderValueCoef + defaultValue, forKey: valueKey)
                ciFilter.setValue(image, forKey: kCIInputImageKey)
                return ciFilter.outputImage
            }
            
            func copy() -> FilterProtocol {
                let copied = ExposureFilter()
                copied.value = value
                return copied
            }
        }
        
        final class GammaFilter: FilterProtocol {
            
            var ciFilter: CIFilter! = CIFilter(name: "CIGammaAdjust")
            private let valueKey = "inputPower"
            var filterIcon: UIImage? = Resources.Images.ImageEditing.Filters.gamma
            
            private let sliderValueCoef: CGFloat = 0.01
            private let defaultValue: CGFloat = 1
            
            let minSliderValue: CGFloat = -100
            let maxSliderValue: CGFloat = 100
            var value: CGFloat = 0
            
            func apply(for image: CIImage?) -> CIImage? {
                ciFilter.setValue(value * sliderValueCoef + defaultValue, forKey: valueKey)
                ciFilter.setValue(image, forKey: kCIInputImageKey)
                return ciFilter.outputImage
            }
            
            func copy() -> FilterProtocol {
                let copied = GammaFilter()
                copied.value = value
                return copied
            }
        }
        
        final class SaturationFilter: FilterProtocol {
            
            var ciFilter: CIFilter! = CIFilter(name: "CIColorControls")
            private let valueKey = kCIInputSaturationKey
            var filterIcon: UIImage? = Resources.Images.ImageEditing.Filters.saturation
            
            private let sliderValueCoef: CGFloat = 0.01
            private let defaultValue: CGFloat = 1
            
            let minSliderValue: CGFloat = -100
            let maxSliderValue: CGFloat = 100
            var value: CGFloat = 0
            
            func apply(for image: CIImage?) -> CIImage? {
                ciFilter.setValue(value * sliderValueCoef + defaultValue, forKey: valueKey)
                ciFilter.setValue(0, forKey: kCIInputBrightnessKey)
                ciFilter.setValue(1, forKey: kCIInputContrastKey)
                ciFilter.setValue(image, forKey: kCIInputImageKey)
                return ciFilter.outputImage
            }
            
            func copy() -> FilterProtocol {
                let copied = SaturationFilter()
                copied.value = value
                return copied
            }
        }
        
        final class ContrastFilter: FilterProtocol {
            
            var ciFilter: CIFilter! = CIFilter(name: "CIColorControls")
            private let valueKey = kCIInputContrastKey
            var filterIcon: UIImage? = Resources.Images.ImageEditing.Filters.contrast
            
            private let sliderValueCoef: CGFloat = 0.01
            private let defaultValue: CGFloat = 1
            
            let minSliderValue: CGFloat = -100
            let maxSliderValue: CGFloat = 100
            var value: CGFloat = 0
            
            func apply(for image: CIImage?) -> CIImage? {
                ciFilter.setValue(value * sliderValueCoef + defaultValue, forKey: valueKey)
                ciFilter.setValue(0, forKey: kCIInputBrightnessKey)
                ciFilter.setValue(1, forKey: kCIInputSaturationKey)
                ciFilter.setValue(image, forKey: kCIInputImageKey)
                return ciFilter.outputImage
            }
            
            func copy() -> FilterProtocol {
                let copied = ContrastFilter()
                copied.value = value
                return copied
            }
        }
        
        final class BrightnessFilter: FilterProtocol {
            
            var ciFilter: CIFilter! = CIFilter(name: "CIColorControls")
            private let valueKey = kCIInputBrightnessKey
            var filterIcon: UIImage? = Resources.Images.ImageEditing.Filters.brightness
            
            private let sliderValueCoef: CGFloat = 0.01
            private let defaultValue: CGFloat = 0
            
            let minSliderValue: CGFloat = -100
            let maxSliderValue: CGFloat = 100
            var value: CGFloat = 0
            
            func apply(for image: CIImage?) -> CIImage? {
                ciFilter.setValue(value * sliderValueCoef + defaultValue, forKey: valueKey)
                ciFilter.setValue(1, forKey: kCIInputContrastKey)
                ciFilter.setValue(1, forKey: kCIInputSaturationKey)
                ciFilter.setValue(image, forKey: kCIInputImageKey)
                return ciFilter.outputImage
            }
            
            func copy() -> FilterProtocol {
                let copied = BrightnessFilter()
                copied.value = value
                return copied
            }
        }
        
        final class VibranceFilter: FilterProtocol {
            
            var ciFilter: CIFilter! = CIFilter(name: "CIVibrance")
            private let valueKey = "inputAmount"
            var filterIcon: UIImage? = Resources.Images.ImageEditing.Filters.vibrance
            
            private let sliderValueCoef: CGFloat = 0.05
            private let defaultValue: CGFloat = 0
            
            let minSliderValue: CGFloat = -100
            let maxSliderValue: CGFloat = 100
            var value: CGFloat = 0
            
            func apply(for image: CIImage?) -> CIImage? {
                ciFilter.setValue(value * sliderValueCoef + defaultValue, forKey: valueKey)
                ciFilter.setValue(image, forKey: kCIInputImageKey)
                return ciFilter.outputImage
            }
            
            func copy() -> FilterProtocol {
                let copied = VibranceFilter()
                copied.value = value
                return copied
            }
        }
        
        final class TintFilter: FilterProtocol {
            
            var ciFilter: CIFilter! = CIFilter(name: "CIHueAdjust")
            private let valueKey = "inputAngle"
            var filterIcon: UIImage? = Resources.Images.ImageEditing.Filters.tint
            
            private let sliderValueCoef: CGFloat = 0.05
            private let defaultValue: CGFloat = 0
            
            let minSliderValue: CGFloat = -100
            let maxSliderValue: CGFloat = 100
            var value: CGFloat = 0
            
            func apply(for image: CIImage?) -> CIImage? {
                ciFilter.setValue(value * sliderValueCoef + defaultValue, forKey: valueKey)
                ciFilter.setValue(image, forKey: kCIInputImageKey)
                return ciFilter.outputImage
            }
            
            func copy() -> FilterProtocol {
                let copied = TintFilter()
                copied.value = value
                return copied
            }
        }
        
        
    }
}
