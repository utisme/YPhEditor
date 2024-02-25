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
    
    private let viewModel: ImageEditingViewModelProtocol = ImageEditingViewModel()                  // viewModel должна порождать другую viewModel? (но это неудобно)
    
    private let toolBar = ImageEditingToolBar()
    private let slider = ImageEditingSlider(minValue: -100, maxValue: 100, initValue: 0)            // в дальнейшем поставить слайдер! и назначать каждый раз новый в конфигураторе, который будем вызывать при скроллинге коллекции
    private let collectionView = IEFCollectionView()
    private let metalImageView = ImageEditingMetalImageView()
    

// MARK: - CONFIGURATION
    func configureButtons() {
        
        addNavBarButton(ofType: .options, disposedBy: viewModel.disposeBag, completion: { print("options") })
        addNavBarButton(ofType: .info, disposedBy: viewModel.disposeBag, completion: {print("info")})
        addNavBarButton(ofType: .download, disposedBy: viewModel.disposeBag, completion: {print("download")})
        addNavBarButton(ofType: .upload, disposedBy: viewModel.disposeBag, completion: {print("upload")})
        
        slider.addTarget(nil, action: #selector(sliderAction), for: .valueChanged)
    }
    
    @objc func sliderAction(){
        
    }
}

extension ImageEditingViewController {
    
    override func setConfigurations() {
        super.setConfigurations()
        
        
        configureButtons()
        navigationController?.isToolbarHidden = false
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
            slider,
            collectionView,
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
