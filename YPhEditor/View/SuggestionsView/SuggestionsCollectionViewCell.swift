//
//  SuggestionsCollectionViewCell.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 7.02.24.
//

import UIKit

final class SuggestionsCollectionViewCell: UICollectionViewCell {
    
    static let id = "SuggestionsCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func configure(withImage image: UIImage?) {
        
        imageView.image = image
        
        setConfigurations()
        configureAppearance()
        setupSubviews()
        constraintSubviews()
        
    }
}

extension SuggestionsCollectionViewCell {
    
    private func setConfigurations() {
    
    }
    
    private func configureAppearance() {
        layer.cornerRadius = 4
        clipsToBounds = true
    }
    
    private func setupSubviews() {
        addSubviews(imageView)
    }
    
    private func constraintSubviews() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
