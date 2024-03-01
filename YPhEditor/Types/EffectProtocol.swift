//
//  EffectProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 28.02.24.
//

import Foundation
import CoreImage

protocol EffectProtocol {
    
    func apply(for image: CIImage) -> CIImage
}
