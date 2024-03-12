//
//  AdjustProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 4.03.24.
//

import Foundation
import CoreImage

public protocol AdjustProtocol {
    
    func apply(for image: CIImage?) -> CIImage?
}


