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
    var viewModelForCollection: IEFCollectionViewModelProtocol { get }
    var viewModelForMetalImage: ImageEditingMetalImageViewModelProtocol { get }
    
    var currentCell: (cell: IEFCollectionViewCell, rawValue: Int) { get }
    
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
}
