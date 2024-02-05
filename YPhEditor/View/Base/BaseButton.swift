//
//  BaseButton.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 1.02.24.
//

import UIKit

class BaseButton: UIButton {
    
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
