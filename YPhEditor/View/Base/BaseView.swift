//
//  BaseView.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 22.02.24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConfigurations()
        configureAppearance()
        setupSubviews()
        constraintSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

@objc extension BaseView {
    
    func setConfigurations() {
        
    }
    
    func configureAppearance() {
        
    }
    
    func setupSubviews() {
        
    }
    
    func constraintSubviews() {
        
    }
}
