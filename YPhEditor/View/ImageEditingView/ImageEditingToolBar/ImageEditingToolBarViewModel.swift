//
//  ImageEditingToolBarViewModel.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 1.03.24.
//

import Foundation
import RxSwift

final class ImageEditingToolBarViewModel: ImageEditingToolBarViewModelProtocol {
    
    var superViewModel: ImageEditingViewModelProtocol?
    
    let disposeBag = DisposeBag()
    
    func backwardButtonAction() {
        ImageProcessingManager.shared.cancelLastFiltersChange()
        superViewModel?.updateViews()
    }
    
    func forwardButtonAction() {
        ImageProcessingManager.shared.returnLastFiltersChange()
        superViewModel?.updateViews()
    }
    
    func filtersButtonAction() {
        superViewModel?.showFilters()
    }
    
    func effectsButtonAction() {
        superViewModel?.showEffects()
    }
    
    
}
