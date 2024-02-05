//
//  FilterProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 5.02.24.
//

import Foundation
import CoreImage

protocol Filter {
    var filter: CIFilter! { get }
    
    func apply(for image: CIImage) -> CIImage
}
