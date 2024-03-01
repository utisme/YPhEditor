//
//  ImageEditingViewModelProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 14.02.24.
//

import Foundation
import RxSwift

protocol ImageEditingViewModelProtocol {
    
    var disposeBag: DisposeBag { get }
    
    func subscribeSliderToCollection(completion: @escaping (_ maxValue: CGFloat, _ minValue: CGFloat, _ initValue: CGFloat)->())
}
