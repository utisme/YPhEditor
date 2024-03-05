//
//  ImageEditingSliderViewModel.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 28.02.24.
//

import Foundation

final class ImageEditingSliderViewModel: ImageEditingSliderViewModelProtocol {
    
    var superViewModel: ImageEditingViewModelProtocol?
    
    func valueChanged(_ value: CGFloat) {
        
        superViewModel?.sliderValueChanged(value)
    }
    
    func valueChangingDidFinish(with value: CGFloat) {
        
        superViewModel?.sliderValueChangingDidFinish(with: value)
    }
}
