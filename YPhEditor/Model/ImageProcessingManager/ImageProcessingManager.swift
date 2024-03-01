//
//  ImageProcessingManager.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 2.02.24.
//

import Foundation
import MetalKit
import RxRelay

final class ImageProcessingManager {
    
    static let shared = ImageProcessingManager()
    private init() { }
    
    let device: MTLDevice! = MTLCreateSystemDefaultDevice()
    private let ciContext = CIContext()
    
    var currentFilterObservable = PublishRelay<(CGFloat, CGFloat, CGFloat)>()       // TODO: - нейминги для кортежа
    
    var currentFilter: FilterProtocol? {
        didSet {
            guard let currentFilter else { return }
            guard let previousSimilarFilterIndex = processingStack.firstIndex(where: { $0.ciFilter.name == currentFilter.filterName }) else {
                currentFilterObservable.accept((currentFilter.maxSliderValue, currentFilter.minSliderValue, 0))
                return
            }
            let previousValue = processingStack[previousSimilarFilterIndex].value
            currentFilterObservable.accept((currentFilter.maxSliderValue, currentFilter.minSliderValue, previousValue))
        }
    }
    var currentEffect: EffectProtocol?
    
    private var processingStack: [(ciFilter: CIFilter, value: CGFloat)] = []
    
    func appendToProcessingStack(_ ciFilter: CIFilter, with value: CGFloat) {
        if let previousSimilarFilterIndex = processingStack.firstIndex(where: { $0.ciFilter.name == ciFilter.name }) {
            processingStack[previousSimilarFilterIndex] = (ciFilter, value)
        } else {
            processingStack.append((ciFilter, value))
        }
    }
    
    func applyProcessingStack(for image: CIImage) -> CIImage? {
        
        var outputImage: CIImage? = image
        processingStack.forEach { filter in
            filter.ciFilter.setValue(outputImage, forKey: kCIInputImageKey)
            outputImage = filter.ciFilter.outputImage
        }
        return outputImage
    }
}
