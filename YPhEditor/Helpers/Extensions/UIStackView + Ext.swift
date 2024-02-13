//
//  UIStackView + Ext.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 12.02.24.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
