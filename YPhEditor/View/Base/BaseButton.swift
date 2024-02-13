//
//  BaseButton.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 1.02.24.
//

import UIKit
import RxSwift

class BaseButton: UIButton {
    
    func setCompletion(disposedBy disposeBag: DisposeBag, completion: @escaping ()->()) {
            
        self.rx
            .tap
            .bind(onNext: completion)
            .disposed(by: disposeBag)
    }
}

// MARK: - ANIMATION
extension BaseButton {
    func addAnimation() {
        
        self.addTarget(self, action: #selector(touchDownAnimation), for: [
            .touchDown,
            .touchDragInside
        ])
        
        self.addTarget(self, action: #selector(touchUpAnimation), for: [
            .touchDragOutside,
            .touchUpInside,
            .touchUpOutside,
            .touchDragExit,
            .touchCancel
        ])
    }
    
    @objc func touchDownAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.7
        }
    }
    
    @objc func touchUpAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
}
