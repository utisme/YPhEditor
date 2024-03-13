//
//  IEECollectionViewCell.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 6.03.24.
//

import UIKit

final class IEECollectionViewCell: BaseCollectionCell {
    
    var viewModel: IECollectionViewModelProtocol?
    
    static let id = "IEECollectionViewCell"
    
    private let imageView = UIImageView()
    
    func configure(withImage image: UIImage?) {
        imageView.image = image
        
    }
    
}

extension IEECollectionViewCell {
    override func setConfigurations() {
        super.setConfigurations()
        
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubviews(imageView)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
