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
        
        setConfigurations()
        configureAppearance()
        setupSubviews()
        constraintSubviews()
    }
    
    func addNavBarButton(ofType type: NavBarButtonType, disposedBy disposeBag: DisposeBag, completion: @escaping ()->Void) {
        let button: UIBarButtonItem
        
        switch type {
            
        case .options:
            button = UIBarButtonItem(
                image: Resources.Images.NavBar.options,
                style: .plain,
                target: nil,
                action: nil)
        case .info:
            button = UIBarButtonItem(
                image: Resources.Images.NavBar.info,
                style: .plain,
                target: nil,
                action: nil)
        case .download:
            button = UIBarButtonItem(
                image: Resources.Images.NavBar.download,
                style: .plain,
                target: nil,
                action: nil)
        case .upload:
            button = UIBarButtonItem(
                image: Resources.Images.NavBar.upload,
                style: .plain,
                target: nil,
                action: nil)
        }
        
        button.tintColor = .gray
        navigationItem.rightBarButtonItems?.append(button)
        button.rx
            .tap
            .bind(onNext: completion)
            .disposed(by: disposeBag)
    }
}


@objc extension BaseViewController {
    
    func setConfigurations() {
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
