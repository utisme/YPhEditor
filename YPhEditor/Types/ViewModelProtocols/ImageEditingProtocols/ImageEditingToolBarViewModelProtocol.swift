//
//  ImageEditingToolBarViewModelProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 1.03.24.
//

import Foundation
import RxSwift

protocol ImageEditingToolBarViewModelProtocol {
    
    var disposeBag: DisposeBag { get }
    
    func backwardButtonAction()
    func forwardButtonAction()
    func filtersButtonAction()
    func effectsButtonAction()
}
