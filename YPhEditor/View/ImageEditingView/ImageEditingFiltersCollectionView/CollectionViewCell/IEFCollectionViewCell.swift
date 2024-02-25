//
//  IEFCollectionViewCell.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 19.02.24.
//

import UIKit

final class IEFCollectionViewCell: UICollectionViewCell {
    
    static let id = "IEFCollectionViewCell"
    
    let viewModel: IEFCollectionViewCellViewModelProtocol = IEFCollectionViewCellViewModel()
    
    private let progressView = IEFCollectionViewCellProgressView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.ImageEditing.Filters.exposure
        imageView.tintColor = Resources.Colors.element
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.helveticaRegular(withSize: 13)
        label.textColor = Resources.Colors.element
        label.textAlignment = .center
        return label
    }()
    
    func configure(withValue value: Int) {
        
        setConfigurations()
        configureAppearance()
        setupSubviews()
        constraintSubviews()
        layoutIfNeeded()
        
        let percent = CGFloat(value) / 100
        switch percent {
        case 0:
            
            progressView.configure()
            setImage()
        case (..<0):
            
            progressView.configure(filledTo: percent, clockwise: false)
            setValue(value)
        default:
            
            progressView.configure(filledTo: percent)
            setValue(value)
        }
    }
    
    private func setImage() {
        
        label.isHidden = true
        imageView.isHidden = false
    }
    
    private func setValue(_ value: Int) {
        
        label.text = "\(value)"
        
        imageView.isHidden = true
        label.isHidden = false
    }
}

extension IEFCollectionViewCell {
    
    private func setConfigurations() {
        
    }
    
    private func configureAppearance() {
        
        label.isHidden = true
    }
    
    private func setupSubviews() {
        
        addSubviews(label, imageView, progressView)
    }
    
    private func constraintSubviews() {
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(13)
        }
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(13)
        }
        
        progressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
