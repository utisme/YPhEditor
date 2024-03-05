//
//  ImageEditingViewModel.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 14.02.24.
//

import Foundation
import RxSwift
import UIKit

final class ImageEditingViewModel: ImageEditingViewModelProtocol {
    
//MARK: View Models
    lazy var viewModelForToolbar: ImageEditingToolBarViewModelProtocol = {
        let viewModel = ImageEditingToolBarViewModel()
        viewModel.superViewModel = self
        return viewModel
    }()
    
    lazy var viewModelForSlider: ImageEditingSliderViewModelProtocol = {
        let viewModel = ImageEditingSliderViewModel()
        viewModel.superViewModel = self
        return viewModel
    }()
    
    lazy var viewModelForCollection: IEFCollectionViewModelProtocol = {
        let viewModel = IEFCollectionViewModel()
        viewModel.superViewModel = self
        return viewModel
    }()
    
    var viewModelForMetalImage: ImageEditingMetalImageViewModelProtocol {
        ImageEditingMetalImageViewModel()
    }
    
// MARK: Logic
    let disposeBag = DisposeBag()
    
    var adjustsType: ImageProcessingManager.Adjust = .filters
    
    var currentCell: (cell: IEFCollectionViewCell, rawValue: Int) {
        viewModelForCollection.currentCell
    }
    private var slider: ImageEditingSlider?
    
    func showFilters() {
        adjustsType = .filters
        updateViews()
    }
    
    func showEffects() {
        adjustsType = .effects
        updateViews()
    }
    
    func setViewsConfigurations(slider: ImageEditingSlider) {
        self.slider = slider
    }
    
    func sliderValueChanged(_ value: CGFloat) {
        ImageProcessingManager.shared.filtersStack[currentCell.rawValue].value = value
        currentCell.cell.configure(withValue: value)
    }
    
    func sliderValueChangingDidFinish(with value: CGFloat) {
        ImageProcessingManager.shared.valueChangingDidFinish(for: currentCell.rawValue, with: value)
    }
    
    func configureSlider() {
        let correspondingFilter = ImageProcessingManager.shared.filtersStack[currentCell.rawValue]
        slider?.configure(minValue: correspondingFilter.minSliderValue, maxValue: correspondingFilter.maxSliderValue, initValue: correspondingFilter.value)
    }
    
    func collectionDidLoaded() {
        if adjustsType == .filters {
            configureSlider()
        }
    }
    
    func cellChanged() {
        switch adjustsType {
        case .filters:
            configureSlider()
        case .effects:
            ImageProcessingManager.shared.applyEffect(with: currentCell.rawValue)
        }
    }

    func updateViews() {
        switch adjustsType {
        case .filters:
            slider?.isHidden = false
            viewModelForCollection.configureForFilters()
            
        case .effects:
            slider?.isHidden = true
            viewModelForCollection.configureForEffects()
        }
    }
}
