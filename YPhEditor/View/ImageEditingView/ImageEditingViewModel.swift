//
//  ImageEditingViewModel.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 14.02.24.
//

import Foundation
import RxSwift
import RxRelay
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
    lazy var viewModelForCollection: IECollectionViewModelProtocol = {
        let viewModel = IECollectionViewModel()
        viewModel.superViewModel = self
        return viewModel
    }()
    let viewModelForMetalImage: ImageEditingMetalImageViewModelProtocol = ImageEditingMetalImageViewModel()
    var viewModelForUploadingView: ImageEditingUploadingViewModelProtocol = ImageEditingUploadingViewModel()
//    let viewModelForInfoView: InfoViewModelProtocol = InfoViewModel()
//    let viewModelForSettingsView: SettingsViewModelProtocol = SettingsViewModel()

//MARK: RX
    let disposeBag = DisposeBag()
    let uploadObservable = PublishRelay<String>()
    let aiFilterObservable = PublishRelay<Bool>()
    
    
//MARK: Adjust applying logic
    var adjustsType: ImageProcessingManager.Adjust = .filters
    
    var currentCell: (cell: UICollectionViewCell, rawValue: Int) {
        viewModelForCollection.currentCell
    }
    private var slider: ImageEditingSlider?
    
    func showFilters() {
        adjustsType = .filters
        viewModelForCollection.configureForFilters()
        updateViews()
    }
    
    func showEffects() {
        adjustsType = .effects
        viewModelForCollection.configureForEffects()
        updateViews()
    }
    
    func setViewsConfigurations(slider: ImageEditingSlider) {
        self.slider = slider
    }
    
    func sliderValueChanged(_ value: CGFloat) {
        guard let cell = currentCell.cell as? IEFCollectionViewCell else { return }
        ImageProcessingManager.shared.filtersStack[currentCell.rawValue].value = value
        cell.configure(withValue: value)
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
            viewModelForCollection.updateCollection()
            configureSlider()
            
        case .effects:
            slider?.isHidden = true
            viewModelForCollection.updateCollection()
        }
    }
    
    //MARK: NavBarButtons Actions
    
    func subscribeToUploadObservable(completion: @escaping(_ url: String, _ uploadingViewModel: ImageEditingUploadingViewModelProtocol)->Void) {//TODO: переделать под комплишены все подобные случаи
        NetworkManager.shared.uploadObservable
            .asDriver(onErrorJustReturn: "Image uploading error")
            .drive { [weak self] url in
                guard let self else {
                    debugPrint(":: Error: ImageEditingViewModel -> subscribeToViewModel(): Guard error")
                    return }
                
                viewModelForUploadingView.url = url
                completion(url, viewModelForUploadingView)
            }
            .disposed(by: disposeBag)
    }
    
    func subscribeToAIFilterObservable(completion: @escaping (_:Bool) -> Void) {
        aiFilterObservable
            .asDriver(onErrorJustReturn: true)
            .drive(onNext: completion)
            .disposed(by: disposeBag)
    }
    
    func downloadImageCompletion() -> ()->Void {
        { CurrentImageManager.shared.saveImageToGallery() }
    }
    
    func uploadImageCompletion() -> ()->Void {
        { CurrentImageManager.shared.uploadImage() }
    }
    
    func applyAIFilter() {
        Task { [weak self] in
            guard let processedImage = await ImageProcessingManager.Tools.applyPaprikaFor(CurrentImageManager.shared.currentCGImage),
                  let orientation = CurrentImageManager.shared.currentUIImage?.imageOrientation,
                  let originalSize = CurrentImageManager.shared.currentUIImage?.size
            else {
                debugPrint(":: Error: ImageEditingViewModel -> applyAICompletion(): Unable to set image at CurrentImageManager -> currentUIImage")
                return }
            
            let xScale = originalSize.width / CGFloat(processedImage.width)
            let yScale = originalSize.height / CGFloat(processedImage.height)
            let scale = originalSize.width < originalSize.height ? xScale : yScale
            let size = CGSize(width: originalSize.width / scale, height: originalSize.height / scale)
            
            let image = UIImage(cgImage: processedImage, scale: 3, orientation: orientation).resizedTo(size)
            CurrentImageManager.shared.currentUIImage = image
            self?.aiFilterObservable.accept(true)
        }
    }
}
