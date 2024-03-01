//
//  Filter.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 28.02.24.
//

import Foundation
import MetalKit
import RxRelay

extension ImageProcessingManager {
    
    func setFilter(with rawValue: Int) {
        guard let filter = Filter(rawValue: rawValue) else { return }       //TODO: handle error
        
        switch filter {
        case .exposure:
            ImageProcessingManager.shared.currentFilter = Filter.ExposureFilter()
        case .gamma:
            ImageProcessingManager.shared.currentFilter = Filter.GammaFilter()
        }
    }
    
    //TODO: РАССМОТРЕТЬ ЗДЕСЬ ПРИМЕНЕНИЕ ФАБРИКИ
    
    enum Filter: Int, CaseIterable {
        case exposure, gamma
        
        // MARK: - FILTERS
        
        final class ExposureFilter: FilterProtocol {
            
            let filterName: String = "CIExposureAdjust"
            let minSliderValue: CGFloat = -100
            let maxSliderValue: CGFloat = 100
            
            private lazy var filter: CIFilter! = CIFilter(name: filterName)
            private let sliderValueCoef: CGFloat = 0.05
            private let defaultValue: CGFloat = 0
            
            var valueObservable: PublishRelay<CGFloat>? = PublishRelay<CGFloat>()
            
            func applyFilter(with value: CGFloat) {
                
                valueObservable?.accept(value)
                addFilterToStack(with: value)
            }
            
            private func addFilterToStack(with value: CGFloat) {
                
                filter.setValue(value * sliderValueCoef + defaultValue, forKey: kCIInputEVKey)
                ImageProcessingManager.shared.appendToProcessingStack(filter, with: value)
            }
        }
        
        final class GammaFilter: FilterProtocol {
            
            let filterName: String = "CIGammaAdjust"
            let minSliderValue: CGFloat = -100
            let maxSliderValue: CGFloat = 100
            
            private lazy var filter: CIFilter! = CIFilter(name: filterName)
            private let sliderValueCoef: CGFloat = 0.01
            private let defaultValue: CGFloat = 1
            
            
            var valueObservable: PublishRelay<CGFloat>? = PublishRelay<CGFloat>()
            
            func applyFilter(with value: CGFloat) {
                
                valueObservable?.accept(value)
                addFilterToStack(with: value)
            }
            
            private func addFilterToStack(with value: CGFloat) {
                
                filter.setValue(value * sliderValueCoef + defaultValue, forKey: "inputPower")
                ImageProcessingManager.shared.appendToProcessingStack(filter, with: value)
            }
        }
    }
}
