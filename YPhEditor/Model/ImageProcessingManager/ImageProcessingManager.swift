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
    
    let device: MTLDevice! = MTLCreateSystemDefaultDevice()
    let ciContext = CIContext()
    
    var filtersStack: [FilterProtocol] = []
    private var previousAdjustsStack: [AdjustProtocol] = []
    private var canceledAdjustsStack: [AdjustProtocol] = []
    
    var currentEffect: EffectProtocol = Adjust.Effect.WithoutEffect()
    
    private init() {
        debugPrint(":: Initialization ImageProcessingManager")
        Adjust.Filter.allCases.forEach {
            filtersStack.append($0.getFilter())
        }
    }

//MARK: Adjust logic
    func applyProcessingStack(for image: CIImage?) -> CIImage? {
        var outputImage: CIImage? = image
        filtersStack.forEach { filter in
            outputImage = filter.apply(for: outputImage)
        }
        
        outputImage = currentEffect.apply(for: outputImage)
        
        return outputImage
    }
    
    func valueChangingDidFinish(for index: Int, with value: CGFloat) {
        guard index < filtersStack.count else {
            debugPrint(":: Error: ImageProcessingManager -> valueChangingDidFinish: Attempt to access a non-existing filter")
            return
        }
        
        previousAdjustsStack.append(filtersStack[index].copy())
        canceledAdjustsStack.removeAll()
    }
    
    func applyEffect(with rawValue: Int) {
        guard let effect = Adjust.Effect(rawValue: rawValue)?.getEffect() else {
            debugPrint(":: Error: ImageProcessingManager -> applyEffect: Attempt to access a non-existing filter")
            return
        }
        
        currentEffect = effect
        if let _ = previousAdjustsStack.last as? EffectProtocol {
            previousAdjustsStack.removeLast()
        }
        previousAdjustsStack.append(effect)
        canceledAdjustsStack.removeAll()
    }

// MARK: Adjust buffer logic
    func cancelLastFiltersChange() {
        
        if let currentFilter = previousAdjustsStack.last,
           let correspondingIndex = filtersStack.firstIndex(where: { type(of: $0) == type(of: currentFilter) }) {
            
            canceledAdjustsStack.append(currentFilter)
            previousAdjustsStack.removeLast()
            
            guard let previousFilter = previousAdjustsStack.reversed().first(where: { type(of: $0) == type(of: currentFilter) }),
                  let previousFilter = previousFilter as? FilterProtocol
            else {
                filtersStack[correspondingIndex].value = 0
                return
            }
            
            filtersStack[correspondingIndex].value = previousFilter.value
            
        } else if let _ = previousAdjustsStack.last {
            
            canceledAdjustsStack.append(currentEffect)
            previousAdjustsStack.removeLast()
            currentEffect = Adjust.Effect.WithoutEffect()
        } else {
            debugPrint(":: ImageProcessingManager: no more previous values")         //TODO: возвращать здесь коллекцию в начало
        }
    }
    
    func returnLastFiltersChange() {
        if let filterToReturn = canceledAdjustsStack.last,
           let filterToReturn = filterToReturn as? FilterProtocol,
           let correspondingIndex = filtersStack.firstIndex(where: { type(of: $0) == type(of: filterToReturn) }) {
            
            filtersStack[correspondingIndex].value = filterToReturn.value
            previousAdjustsStack.append(filterToReturn)
            canceledAdjustsStack.removeLast()
        } else if let effectToReturn = canceledAdjustsStack.last,
                  let effectToReturn = effectToReturn as? EffectProtocol
        {
            currentEffect = effectToReturn
            previousAdjustsStack.append(effectToReturn)
            canceledAdjustsStack.removeLast()
        } else {
            debugPrint(":: ImageProcessingManager: no more canceled values")         //TODO: возвращать здесь коллекцию в начало
        }
    }
}
