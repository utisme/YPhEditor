//
//  SuggestionsViewModel.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 6.02.24.
//

import Foundation
import UIKit
import RxSwift

final class SuggestionsViewModel: SuggestionsViewModelProtocol {
    
    private var images: [UIImage] = []
    
    let imagesObservable = PublishSubject<Bool>()
    let disposeBag = DisposeBag()
    
    let vcWillDisappearObservable = PublishSubject<Bool>()
    
    func configure() {
        
        NetworkManager.shared.imagesObservable
            .asObservable()
            .asDriver(onErrorJustReturn: [])
            .drive { [weak self] images in
                self?.images = images
                self?.imagesObservable.onNext(true)
        }
            .disposed(by: disposeBag)
        
        NetworkManager.shared.prepareImages()
    }
    
    func getImageForCell(at indexPath: IndexPath) -> UIImage {
        return images[indexPath.row]
    }
    
    func getNumberOfCells() -> Int {
        return images.count
    }
    
    func getSizeForCell(at view: UIView) -> CGSize {
        
        let cellWidth = view.bounds.width / 2 - 20
        let cellHeight = view.bounds.height / 3 - 25
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func selectCell(withIndexPath indexPath: IndexPath) {
        
        CurrentImageManager.shared.currentUIImage = NetworkManager.shared.images[indexPath.row]
        vcWillDisappearObservable.onNext(true)
    }
}
