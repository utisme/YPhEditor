//
//  ImageEditingUploadingController.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 6.03.24.
//

import UIKit

final class ImageEditingUploadingController: BaseViewController {
    
    let viewModel: ImageEditingUploadingViewModelProtocol
    
    var url: String?
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let cancelButton: IEUButton = {
        let cancelButton = IEUButton()
        cancelButton.configure(withText: Resources.Strings.ImageEditing.Uploding.cancelButton)
        return cancelButton
    }()
    
    let copyButton: IEUButton = {
        let copyButton = IEUButton()
        copyButton.configure(withText: Resources.Strings.ImageEditing.Uploding.copyButton)
        return copyButton
    }()
    
    init(viewModel: ImageEditingUploadingViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        copyButton.setCompletion(disposedBy: viewModel.disposeBag, completion: { [unowned self] in
            viewModel.copyToPasteboardCompletion()
            dismiss(animated: true)
        })
        cancelButton.setCompletion(disposedBy: viewModel.disposeBag, completion: { [unowned self] in dismiss(animated: true) })
        
        imageView.image = viewModel.prepareQR()
    }
    
    required init?(coder: NSCoder) { nil }
    
}

extension ImageEditingUploadingController {
    override func setConfigurations() {
        super.setConfigurations()
        
        
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        view.backgroundColor = Resources.Colors.background?.withAlphaComponent(0.3)
        imageView.layer.cornerRadius = 40
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        view.addSubviews(imageView, cancelButton, copyButton)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(100)
            make.height.equalTo(imageView.snp.width)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(0.5)
            make.leading.equalTo(imageView.snp.leading)
            make.width.equalTo(imageView.snp.width).dividedBy(2).inset(0.16)
        }
        
        copyButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(0.5)
            make.trailing.equalTo(imageView.snp.trailing)
            make.width.equalTo(cancelButton.snp.width)
        }
    }
}


