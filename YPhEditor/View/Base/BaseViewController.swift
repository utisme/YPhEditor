//
//  BaseViewController.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 31.01.24.
//

import UIKit
import RxCocoa
import RxSwift

class BaseViewController: UIViewController {    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureAppearance()
        setupSubviews()
        constraintSubviews()
    }
    
    func addNavBarButton(ofType type: NavBarButtonType, disposedBy disposeBag: DisposeBag, completion: @escaping ()->Void) {
        switch type {
            
        case .options:
            let button = UIBarButtonItem(image: .init(systemName: "ellipsis.circle.fill"), 
                                         style: .plain,
                                         target: nil,
                                         action: nil)
            
            button.rx
                .tap
                .bind(onNext: completion)
                .disposed(by: disposeBag)
            
            button.tintColor = .gray
            navigationItem.rightBarButtonItems?.append(button)
        }  
    }
}


@objc extension BaseViewController {
    
    func configure() {
        navigationItem.rightBarButtonItems = []
    }
    
    func configureAppearance() {
        
        view.backgroundColor = Resources.Colors.background
    }
    
    func setupSubviews() {
        
    }
    
    func constraintSubviews() {
        
    }
}
