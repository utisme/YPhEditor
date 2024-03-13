//
//  MenuButton.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 31.01.24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MenuButton: BaseButton {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Resources.Colors.elementGray
        label.font = Resources.Fonts.helveticaRegular(withSize: 13)
        return label
    }()
    
    func configure(withLabel label: String?) {
        self.label.text = label
    }
}

extension MenuButton {
    
    override func setConfigurations() {
        addAnimation()
    }
    
    override func configureAppearance() {
        backgroundColor = Resources.Colors.element
    }
    
    override func setupSubviews() {
        addSubviews(label)
    }
    
    override func constraintSubviews() {
        label.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(13)
            make.centerX.equalToSuperview()
        }
    }
}
