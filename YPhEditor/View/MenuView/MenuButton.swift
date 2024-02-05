//
//  MenuButton.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 31.01.24.
//

import UIKit
import SnapKit

class MenuButton: BaseButton {
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Resources.Colors.elementGray
        label.font = Resources.Fonts.helveticaRegular(withSize: 13)
        return label
    }()
    
    func configure(withLabel label: String?) {
        configureAppearance()
        setupSubviews()
        constraintSubviews()
        
        addAnimation()
        
        self.label.text = label
    }
}

extension MenuButton {
    func configureAppearance() {
        backgroundColor = Resources.Colors.element
    }
    
    func setupSubviews() {
        addSubviews(label)
    }
    
    func constraintSubviews() {
        label.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(13)
            make.centerX.equalToSuperview()
        }
    }
}
