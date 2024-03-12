//
//  InfoCollectionViewCell.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 11.03.24.
//

import UIKit

final class InfoCollectionViewCell: BaseCollectionCell {
    
    static let id = "InfoViewTableCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.element
        label.textAlignment = .center
        label.font = Resources.Fonts.helveticaRegular(withSize: 13)
        return label
    }()
    
    let valueLabel: UILabel = {
        let valueLabel = UILabel()
        valueLabel.textColor = Resources.Colors.element
        valueLabel.textAlignment = .center
        valueLabel.font = Resources.Fonts.helveticaRegular(withSize: 13)
        return valueLabel
    }()
    
    func configure(withLabel label: String?, value: String?) {
        self.label.text = label
        valueLabel.text = value
    }
}

extension InfoCollectionViewCell {
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubviews(label, valueLabel)
    }
    
    override func constraintSubviews() {
        label.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
