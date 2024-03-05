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
    
    var viewModelForSuggestionsView: SuggestionsViewModelProtocol {
        
        let suggestionsViewModel = SuggestionsViewModel()
        suggestionsViewModel.vcWillDisappearObservable
            .asObservable()
            .asDriver(onErrorJustReturn: true)
            .drive { [weak self] _ in
                self?.needShowImageProcessingVC.onNext(true)
            }
            .disposed(by: disposeBag)
        
        return suggestionsViewModel
    }
    var viewModelForIEView: ImageEditingViewModel {
        ImageEditingViewModel()
    }
    
    let needShowImageProcessingVC = PublishSubject<Bool>()
    let disposeBag = DisposeBag()
    
    func navBarButtonAction() {
        print("nav button action")
    }
    
    func pickImage(_ image: UIImage?) {
        
        CurrentImageManager.shared.currentUIImage = image
        needShowImageProcessingVC.onNext(true)
    }
}
