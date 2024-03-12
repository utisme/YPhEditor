//
//  ImageEditingUploadingViewModelProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 7.03.24.
//

import Foundation
import UIKit
import RxSwift

protocol ImageEditingUploadingViewModelProtocol {
    var disposeBag: DisposeBag { get }
    var url: String? { get set }
    
    func prepareQR() -> UIImage
    func copyToPasteboardCompletion()
}
