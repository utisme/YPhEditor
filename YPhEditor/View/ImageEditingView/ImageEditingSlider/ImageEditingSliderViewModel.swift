//
//  ImageEditingSliderViewModel.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 28.02.24.
//

import Foundation

final class ImageEditingSliderViewModel: ImageEditingSliderViewModelProtocol {
    
    func valueChanged(_ value: CGFloat) {
        
        ImageProcessingManager.shared.currentFilter?.applyFilter(with: value)
    }
}
