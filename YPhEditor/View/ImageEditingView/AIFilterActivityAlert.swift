//
//  AIFilterActivityAlert.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 14.03.24.
//

import UIKit

final class AIFilterActivityAlert: UIAlertController {
    
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppearance()
        setupSubviews()
        constraintSubviews()
        
        activityIndicator.startAnimating()
    }
}

extension AIFilterActivityAlert {
    
    private func configureAppearance() {
        activityIndicator.style = .medium
    }
    
    private func setupSubviews() {
        view.addSubviews(activityIndicator)
    }
    
    private func constraintSubviews() {
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.4)
        }
        
        view.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
    }
}
