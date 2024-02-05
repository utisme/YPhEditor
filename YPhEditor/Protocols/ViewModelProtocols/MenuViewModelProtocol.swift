//
//  MenuViewModelProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 2.02.24.
//

import Foundation
import UIKit

protocol MenuViewModelProtocol {
    func prepareImage(_ image: CIImage, to view: MetalImageView) -> CIImage
}
