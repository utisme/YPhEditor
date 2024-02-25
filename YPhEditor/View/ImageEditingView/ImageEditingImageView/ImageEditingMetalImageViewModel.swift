//
//  ImageEditingMetalImageViewModel.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 22.02.24.
//

import Foundation
import UIKit
import CoreImage

final class ImageEditingMetalImageViewModel: ImageEditingMetalImageViewModelProtocol {
    
    func getCurrentImage() -> UIImage? {

        guard let image = CurrentImageManager.shared.currentImage
        else {
            print("get current image error")
            return Resources.Images.imageError
        }
        print("current image")
        return UIImage(ciImage: image)
    }
    
    func prepareImage(_ image: CIImage, to view: MetalImageView) -> CIImage {
        
        let scaledToViewImage = ImageProcessingManager.shared.fitImage(image, to: view, minScale: true)

        return scaledToViewImage
    }
}
