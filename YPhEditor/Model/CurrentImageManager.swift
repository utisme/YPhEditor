//
//  CurrentImageManager.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 8.02.24.
//

import Foundation
import CoreImage

final class CurrentImageManager {
    
    static let shared = CurrentImageManager()
    private init() {}
    
    var currentImage: CIImage?
    
    func applyFilter(_ filter: Filter) -> CIImage? {
        currentImage
    }
}
