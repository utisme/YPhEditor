//
//  SuggestionsCollectionViewCell.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 7.02.24.
//

import UIKit

final class SuggestionsCollectionViewCell: UICollectionViewCell {
    
    static let id = "SuggestionsCollectionViewCell"
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func configure(withImage image: UIImage?) {
        
        imageView.image = image
        
        configureAppearance()
        setupSubviews()
        constraintSubviews()
        
    }
}

extension SuggestionsCollectionViewCell {
    func configureAppearance() {
        layer.cornerRadius = 4
        clipsToBounds = true
    }
    
    func setupSubviews() {
        addSubviews(imageView)
    }
    
    func constraintSubviews() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
