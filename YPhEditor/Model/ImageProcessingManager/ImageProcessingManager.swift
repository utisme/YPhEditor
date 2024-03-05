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
    private let ciContext = CIContext()
    
    var filtersStack: [FilterProtocol] = []
    private var previousFiltersStack: [AdjustProtocol] = []
    private var canceledFiltersStack: [AdjustProtocol] = []
    
    
    var effectsStack: [EffectProtocol] = []
    var applyingEffectsStack: [Int] = []
    
    private init() {
        Adjust.Filter.allCases.forEach {
            filtersStack.append($0.getFilter())
        }
        
        Adjust.Effect.allCases.forEach {
            effectsStack.append($0.getEffect())
        }
    }
    
    func applyProcessingStack(for image: CIImage) -> CIImage? {
        
        var outputImage: CIImage? = image
        filtersStack.forEach { filter in
            outputImage = filter.apply(for: outputImage)
        }
        applyingEffectsStack.forEach { index in
            outputImage = effectsStack[index].apply(for: outputImage)
            
        }
        return outputImage
    }
    
    func valueChangingDidFinish(for index: Int, with value: CGFloat) {
        guard index < filtersStack.count else { return }            //TODO: handle error
        
        previousFiltersStack.append(filtersStack[index].copy())
        canceledFiltersStack.removeAll()
    }
    
    func applyEffect(with rawValue: Int) {
        guard applyingEffectsStack.first(where: { $0 == rawValue }) == nil,
              let effect = Adjust.Effect(rawValue: rawValue)?.getEffect()
        else { return }                                                 //TODO: handle error
        applyingEffectsStack.append(rawValue)
        previousFiltersStack.append(effect)         
        canceledFiltersStack.removeAll()
    }
    
    func cancelLastFiltersChange() {
        
        if let currentFilter = previousFiltersStack.last,
           let correspondingIndex = filtersStack.firstIndex(where: { type(of: $0) == type(of: currentFilter) }) {
            
            canceledFiltersStack.append(currentFilter)
            previousFiltersStack.removeLast()
            
            guard let previousFilter = previousFiltersStack.reversed().first(where: { type(of: $0) == type(of: currentFilter) }),
                  let previousFilter = previousFilter as? FilterProtocol
            else {
                filtersStack[correspondingIndex].value = 0
                return
            }
            
            filtersStack[correspondingIndex].value = previousFilter.value
            
        } else if let currentEffect = previousFiltersStack.last,
                  let correspondingIndex = effectsStack.firstIndex(where: { type(of: $0) == type(of: currentEffect) }) {
            
            canceledFiltersStack.append(currentEffect)
            previousFiltersStack.removeLast()
            
            guard let indexToCancel = applyingEffectsStack.firstIndex(where: { $0 == correspondingIndex }) else { return }              //TODO: handle error
            applyingEffectsStack.remove(at: indexToCancel)
        } else {
            debugPrint("error")         //TODO: handle error
        }
    }
    
    func returnLastFiltersChange() {
        if let filterToReturn = canceledFiltersStack.last,
           let filterToReturn = filterToReturn as? FilterProtocol,
           let correspondingIndex = filtersStack.firstIndex(where: { type(of: $0) == type(of: filterToReturn) }) {
            
            filtersStack[correspondingIndex].value = filterToReturn.value
            previousFiltersStack.append(filterToReturn)
            canceledFiltersStack.removeLast()
        } else if let effectToReturn = canceledFiltersStack.last,
                  let effectToReturn = effectToReturn as? EffectProtocol,
                  let correspondingIndex = effectsStack.firstIndex(where: { type(of: $0) == type(of: effectToReturn )}),
                  let correspondingEffect = Adjust.Effect(rawValue: correspondingIndex)?.getEffect()
        {
            applyingEffectsStack.append(correspondingIndex)
            previousFiltersStack.append(correspondingEffect)
            canceledFiltersStack.removeLast()
        } else {
            debugPrint("error")         //TODO: handle error
        }
    }
}
