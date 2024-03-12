//
//  BaseCollectionCell.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 6.03.24.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConfigurations()
        configureAppearance()
        setupSubviews()
        constraintSubviews()
    }
    
    required init?(coder: NSCoder) { nil }
}

@objc extension BaseCollectionCell {
    
    func setConfigurations() {
        
    }
    
    func configureAppearance() {
        
    }
    
    func setupSubviews() {
        
    }
    
    func constraintSubviews() {
        
    }
}
