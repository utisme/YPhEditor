//
//  ImageEditingUploadingViewModel.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 7.03.24.
//

import UIKit
import RxSwift

final class ImageEditingUploadingViewModel: ImageEditingUploadingViewModelProtocol {
    
    let disposeBag = DisposeBag()
    
    var url: String?
    
    func prepareQR() -> UIImage {
        guard let ciImage = ImageProcessingManager.Tools.createQRFrom(url) else { return Resources.Images.imageError }
        
        return UIImage(ciImage: ciImage)
    }
    
    func copyToPasteboardCompletion() {
        UIPasteboard.general.string = url
    }
}
