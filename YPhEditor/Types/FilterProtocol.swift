//
//  FilterProtocol.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 5.02.24.
//

import Foundation
import CoreImage
import RxRelay

protocol FilterProtocol {
    
    var filterName: String { get }
    
    var maxSliderValue: CGFloat { get }
    var minSliderValue: CGFloat { get }
    
    var valueObservable: PublishRelay<CGFloat>? { get }
    
    func applyFilter(with value: CGFloat)
}
