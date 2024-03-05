//
//  FilterProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 5.02.24.
//

import Foundation
import UIKit

protocol FilterProtocol: AdjustProtocol {
    
    var filterIcon: UIImage? { get }
    var ciFilter: CIFilter! { get }
    
    var value: CGFloat { get set }
    
    var maxSliderValue: CGFloat { get }
    var minSliderValue: CGFloat { get }
    
    func apply(for image: CIImage?) -> CIImage?
    func copy() -> FilterProtocol
}
