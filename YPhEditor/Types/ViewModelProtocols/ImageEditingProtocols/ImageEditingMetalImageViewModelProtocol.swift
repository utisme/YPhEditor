//
//  ImageEditingMetalImageViewModelProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 22.02.24.
//

import Foundation
import CoreImage
import UIKit

protocol ImageEditingMetalImageViewModelProtocol {
    
    func getCurrentImage() -> CGImage?
    func prepareImage(_ image: CIImage, to view: MetalImageView) -> CIImage
}
