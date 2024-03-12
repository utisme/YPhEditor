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
    
    func addNavBarRightButton(ofType type: NavBarButtonType, disposedBy disposeBag: DisposeBag, completion: @escaping ()->Void) {
        
        let button = getButtonOfType(type)
        navigationItem.rightBarButtonItems?.append(button)
        button.rx
            .tap
            .bind(onNext: completion)
            .disposed(by: disposeBag)
    }
    
    func addNavBarLeftButton(ofType type: NavBarButtonType, disposedBy disposeBag: DisposeBag, completion: @escaping ()->Void) {
        
        let button = getButtonOfType(type)
        navigationItem.leftBarButtonItems?.append(button)
        button.rx
            .tap
            .bind(onNext: completion)
            .disposed(by: disposeBag)
    }
    
    private func getButtonOfType(_ type: NavBarButtonType) -> UIBarButtonItem {
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
        return button
    }
}


@objc extension BaseViewController {
    
    func setConfigurations() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
    }
    
    func configureAppearance() {
        
        view.backgroundColor = Resources.Colors.background
    }
    
    func setupSubviews() {
        
    }
    
    func constraintSubviews() {
        
    }
}
