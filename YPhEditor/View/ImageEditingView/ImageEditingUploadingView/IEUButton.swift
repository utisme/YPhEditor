//
//  IEUButton.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 7.03.24.
//

import UIKit

final class IEUButton: BaseButton {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Resources.Fonts.helveticaRegular(withSize: 13)
        return label
    }()
    
    func configure(withText text: String) {
        label.text = text
    }
}

extension IEUButton {
    
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
