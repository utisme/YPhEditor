//
//  MenuViewModel.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 2.02.24.
//

import Foundation
import UIKit
import RxSwift

final class MenuViewModel: MenuViewModelProtocol {
    
    let needShowImageProcessingVC = PublishSubject<Bool>()
    let disposeBag = DisposeBag()
    
    func prepareImageForBackground(_ image: CIImage, to view: MetalImageView) -> CIImage {

        let scaledToViewImage = ImageProcessingManager.shared.fitImage(image, to: view)
        
        let monoAreaRect = CGRect(x: view.drawableSize.width / 6,
                                  y: view.drawableSize.height / 3,
                                  width: view.drawableSize.width / 6 * 4,
                                  height: view.drawableSize.height / 2)
        var monoArea = scaledToViewImage.cropped(to: monoAreaRect)
        monoArea = ImageProcessingManager.MonoFilter().apply(for: monoArea)
        
        return monoArea.composited(over: scaledToViewImage)
    }
    
    func galleryButtonAction() {
        
    }
    
    func getSuggestionsViewModel() -> SuggestionsViewModelProtocol {
        
        let suggestionsViewModel = SuggestionsViewModel()
        suggestionsViewModel.vcWillDisappearObservable
            .asObservable()
            .subscribe { [weak self] _ in
                self?.needShowImageProcessingVC.onNext(true)
            }
            .disposed(by: disposeBag)
        
        return suggestionsViewModel
    }
    
    func navBarButtonAction() {
        
    }
}
