//
//  ImageEditingViewModel.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 14.02.24.
//

import Foundation
import RxSwift

final class ImageEditingViewModel: ImageEditingViewModelProtocol {
    
    let disposeBag = DisposeBag()
    
    func subscribeSliderToCollection(completion: @escaping (CGFloat, CGFloat, CGFloat) -> ()) {
        
        ImageProcessingManager.shared.currentFilterObservable
            .asObservable()
            .subscribe { maxValue, minValue, initValue in
                completion(maxValue, minValue, initValue)
            }
            .disposed(by: disposeBag)
    }
    
}
