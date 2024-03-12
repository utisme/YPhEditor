//
//  ImageEditingViewModelProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 14.02.24.
//

import Foundation
import RxSwift
import UIKit

protocol ImageEditingViewModelProtocol {
    
    var viewModelForToolbar: ImageEditingToolBarViewModelProtocol { get }
    var viewModelForSlider: ImageEditingSliderViewModelProtocol { get }
    var viewModelForCollection: IECollectionViewModelProtocol { get }
    var viewModelForMetalImage: ImageEditingMetalImageViewModelProtocol { get }
    var viewModelForUploadingView: ImageEditingUploadingViewModelProtocol { get }
//    var viewModelForInfoView: InfoViewModelProtocol { get }
//    var viewModelForSettingsView: SettingsViewModelProtocol { get }
    
    var currentCell: (cell: UICollectionViewCell, rawValue: Int) { get }
    
    var disposeBag: DisposeBag { get }
    
    var adjustsType: ImageProcessingManager.Adjust { get set }
    func showFilters()
    func showEffects()
    
    func setViewsConfigurations(slider: ImageEditingSlider)
    func collectionDidLoaded()
    
    func sliderValueChanged(_ value: CGFloat)
    func sliderValueChangingDidFinish(with value: CGFloat)
    
    func cellChanged()
    
    func updateViews()
    
    //MARK: NavBar actions
    func subscribeToViewModel(completion: @escaping(_ url: String, _ uploadingViewModel: ImageEditingUploadingViewModelProtocol)->Void)
    func downloadImageCompletion() -> ()->Void
    func uploadImageCompletion() -> ()->Void
    func applyAICompletion() -> ()->Void
}
