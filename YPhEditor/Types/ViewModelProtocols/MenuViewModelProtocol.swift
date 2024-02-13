//
//  MenuViewModelProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 2.02.24.
//

import Foundation
import UIKit
import RxSwift

protocol MenuViewModelProtocol {
    
    var needShowImageProcessingVC: PublishSubject<Bool> { get }
    var disposeBag: DisposeBag { get }
    
    func prepareImageForBackground(_ image: CIImage, to view: MetalImageView) -> CIImage
    func navBarButtonAction()
    func getSuggestionsViewModel() -> SuggestionsViewModelProtocol
    func pickImage(_ image: UIImage?)
}
