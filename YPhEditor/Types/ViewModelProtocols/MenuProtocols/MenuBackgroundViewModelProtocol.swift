//
//  MenuBackgroundViewModelProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 22.02.24.
//

import Foundation
import CoreImage

protocol MenuBackgroundViewModelProtocol {
    
    func prepareImage(_ image: CIImage, to view: MetalImageView) -> CIImage
}
