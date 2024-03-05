//
//  ImageEditingToolBar.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 14.02.24.
//

import UIKit
import RxCocoa

final class ImageEditingToolBar: UIToolbar {
    
    private let viewModel: ImageEditingToolBarViewModelProtocol
    
    private let backwardButton = UIBarButtonItem(image: Resources.Images.ImageEditing.ToolBar.backward)
    private let effectsButton = UIBarButtonItem(image: Resources.Images.ImageEditing.ToolBar.effects)
    private let filtersButton = UIBarButtonItem(image: Resources.Images.ImageEditing.ToolBar.filters)
    private let forwardButton = UIBarButtonItem(image: Resources.Images.ImageEditing.ToolBar.forward)
    private let flexibleSpace = UIBarButtonItem(
        barButtonSystemItem: .flexibleSpace,
        target: nil,
        action: nil)
    
    init(viewModel: ImageEditingToolBarViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
        
        setConfigurations()
        configureAppearance()
        setupSubviews()
        constraintSubviews()
    }
    
    required init?(coder: NSCoder) { nil }
    
    func configureButtons() {
        
        backwardButton.rx.tap.subscribe(onNext: { [unowned self] in
            viewModel.backwardButtonAction()
        }).disposed(by: viewModel.disposeBag)
        
        effectsButton.rx.tap.subscribe(onNext: { [unowned self] in
            viewModel.effectsButtonAction()
        }).disposed(by: viewModel.disposeBag)
        
        filtersButton.rx.tap.subscribe(onNext: { [unowned self] in
            viewModel.filtersButtonAction()
        }).disposed(by: viewModel.disposeBag)
        
        forwardButton.rx.tap.subscribe(onNext: { [unowned self] in
            viewModel.forwardButtonAction()
        }).disposed(by: viewModel.disposeBag)
        
    }
}

extension ImageEditingToolBar {
    
    func setConfigurations() {
        configureButtons()
    }
    
    func configureAppearance() {
        
        let appearance = UIToolbarAppearance()
        appearance.backgroundColor = Resources.Colors.background
        standardAppearance = appearance
        tintColor = Resources.Colors.element
    }
    
    func setupSubviews() {
        setItems([flexibleSpace, backwardButton, 
                  flexibleSpace, filtersButton, effectsButton,
                  flexibleSpace, forwardButton,
                  flexibleSpace], animated: false)
    }
    
    func constraintSubviews() {
        
    }
}
