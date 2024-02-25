//
//  ImageEditingToolBar.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 14.02.24.
//

import UIKit

final class ImageEditingToolBar: UIToolbar {
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))        // чревато ошибкой по констрейтам
        
        setConfigurations()
        configureAppearance()
        setupSubviews()
        constraintSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let backwardButton = UIBarButtonItem(image: Resources.Images.ImageEditing.ToolBar.backward)
    
    private let adjustButton = UIBarButtonItem(image: Resources.Images.ImageEditing.ToolBar.adjust)
    
    private let filtersButton = UIBarButtonItem(image: Resources.Images.ImageEditing.ToolBar.filters)
    
    private let forwardButton = UIBarButtonItem(image: Resources.Images.ImageEditing.ToolBar.forward)
    
    private let flexibleSpace = UIBarButtonItem(
        barButtonSystemItem: .flexibleSpace,
        target: nil,
        action: nil)
}

extension ImageEditingToolBar {
    
    func setConfigurations() {
        
    }
    
    func configureAppearance() {
        
        let appearance = UIToolbarAppearance()
        appearance.backgroundColor = Resources.Colors.background
        standardAppearance = appearance
        tintColor = Resources.Colors.element
    }
    
    func setupSubviews() {
        setItems([flexibleSpace, backwardButton, flexibleSpace, adjustButton, filtersButton, flexibleSpace, forwardButton, flexibleSpace], animated: false)
    }
    
    func constraintSubviews() {
        
    }
}
