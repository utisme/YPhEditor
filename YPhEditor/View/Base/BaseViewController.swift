//
//  BaseViewController.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 31.01.24.
//

import UIKit

class BaseViewController: UIViewController {    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppearance()
        setupSubviews()
        constraintSubviews()
        
        navigationItem.rightBarButtonItems = []
    }
    
    func addNavBarButton(ofType type: NavBarButtonType, action: Selector?) {
        switch type {
            
        case .options:
            let button = UIBarButtonItem(image: .init(systemName: "ellipsis.circle.fill"), 
                                         style: .plain,
                                         target: self,
                                         action: action)
            button.tintColor = .gray
            navigationItem.rightBarButtonItems?.append(button)
        }  
    }
}


@objc extension BaseViewController {
    func configureAppearance() {
        
        view.backgroundColor = Resources.Colors.background
    }
    
    func setupSubviews() {
        
    }
    
    func constraintSubviews() {
        
    }
}
