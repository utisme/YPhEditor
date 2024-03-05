//
//  ImageEditingViewController.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 9.02.24.
//
// TODO: - Проверить все private (их наличие)

import UIKit
import RxSwift
import MetalKit

final class ImageEditingViewController: BaseViewController {
    
    private let viewModel: ImageEditingViewModelProtocol
    
    private let toolBar: ImageEditingToolBar
    private var slider: ImageEditingSlider
    private let collectionView: IEFCollectionView
    private let metalImageView: ImageEditingMetalImageView
    
    
    // MARK: - CONFIGURATION
    init(viewModel: ImageEditingViewModelProtocol) {
        self.viewModel = viewModel
        
        self.toolBar = ImageEditingToolBar(viewModel: viewModel.viewModelForToolbar)
        self.slider = ImageEditingSlider(viewModel: viewModel.viewModelForSlider)
        self.collectionView = IEFCollectionView(viewModel: viewModel.viewModelForCollection)
        self.metalImageView = ImageEditingMetalImageView(viewModel: viewModel.viewModelForMetalImage)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    func configureButtons() {
        
        addNavBarButton(ofType: .options, disposedBy: viewModel.disposeBag, completion: { print("options") })
        addNavBarButton(ofType: .info, disposedBy: viewModel.disposeBag, completion: { print("info") })
        addNavBarButton(ofType: .download, disposedBy: viewModel.disposeBag, completion: { print("download") })
        addNavBarButton(ofType: .upload, disposedBy: viewModel.disposeBag, completion: { print("upload") })
    }
}

extension ImageEditingViewController {
    
    override func setConfigurations() {
        super.setConfigurations()
        
        viewModel.setViewsConfigurations(slider: slider)
        configureButtons()
    }
  
// MARK: - APPEARANCE
    override func configureAppearance() {
        super.configureAppearance()
        
        navigationItem.hidesBackButton = true
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        view.addSubviews(
            toolBar,
            collectionView,
            slider,
            metalImageView)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        
        toolBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-26)
            make.horizontalEdges.equalToSuperview()
        }

        slider.snp.makeConstraints { make in
            make.bottom.equalTo(toolBar.snp.top).offset(-20)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(toolBar.snp.height)
        }
        
        collectionView.snp.makeConstraints { make in
            make.bottom.equalTo(slider.snp.top).offset(-20)
            make.height.equalTo(60)
            make.horizontalEdges.equalToSuperview()
        }
        
        metalImageView.snp.makeConstraints { make in
            make.bottom.equalTo(collectionView.snp.top).offset(-30)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
        }
    }    
}
