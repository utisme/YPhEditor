//
//  ImageEditingSliderViewModelProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 28.02.24.
//

import Foundation

protocol ImageEditingSliderViewModelProtocol {
    
    var superViewModel: ImageEditingViewModelProtocol? { get }
    
    func valueChanged(_ value: CGFloat)
    func valueChangingDidFinish(with value: CGFloat)
}
