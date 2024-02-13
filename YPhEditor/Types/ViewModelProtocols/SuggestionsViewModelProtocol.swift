//
//  SuggestionsViewModelProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 6.02.24.
//

import Foundation
import UIKit
import RxSwift

protocol SuggestionsViewModelProtocol {
    
    var imagesObservable: PublishSubject<Bool> { get }
    var vcWillDisappearObservable: PublishSubject<Bool> { get }
    var disposeBag: DisposeBag { get }
    
    func configure()
    func getImageForCell(at indexPath: IndexPath) -> UIImage
    func getNumberOfCells() -> Int
    func getSizeForCell(at view: UIView) -> CGSize
    func selectCell(withIndexPath indexPath: IndexPath)
}
