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
    
    var viewModelForIEView: ImageEditingViewModel { get }
    var viewModelForSuggestionsView: SuggestionsViewModelProtocol { get }
    
    var needShowImageProcessingVC: PublishSubject<Bool> { get }
    var disposeBag: DisposeBag { get }
    
    func navBarButtonAction()
    func pickImage(_ image: UIImage?)
}
