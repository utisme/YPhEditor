//
//  MenuBackgroundViewModel.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 22.02.24.
//

import Foundation
import CoreImage

final class MenuBackgroundViewModel: MenuBackgroundViewModelProtocol {
    
    func prepareImage(_ image: CIImage, to view: MetalImageView) -> CIImage {

        let scaledToViewImage = ImageProcessingManager.Transforms.fitImage(image, to: view)
        
        let monoAreaRect = CGRect(x: view.drawableSize.width / 6,
                                  y: view.drawableSize.height / 3,
                                  width: view.drawableSize.width / 6 * 4,
                                  height: view.drawableSize.height / 2)
        let monoArea = scaledToViewImage.cropped(to: monoAreaRect)
        
        let filter = ImageProcessingManager.Adjust.Effect.getEffect(.mono)
        guard let monoArea = filter().apply(for: monoArea) else { return scaledToViewImage }      //TODO: handle error
        
        return monoArea.composited(over: scaledToViewImage)
    }
}
