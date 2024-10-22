//
//  MenuViewController.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 31.01.24.
//

import UIKit
import MetalKit
import RxCocoa

final class MenuViewController: BaseViewController {
    
// MARK: PROPERTIES
    private let viewModel: MenuViewModelProtocol = MenuViewModel()
    
    private var backgroundImage = MenuBackgroundView()
    
    private let stickerView: UIImageView = {
        let stickerView = UIImageView()
        stickerView.image = Resources.Images.Menu.sticker
        stickerView.contentMode = .scaleToFill
        return stickerView
    }()
    
    private let logoImView: UIImageView = {
        let logo = UIImageView()
        logo.image = Resources.Images.Menu.logo
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    private let galleryButton: MenuButton = {
        let button = MenuButton()
        button.configure(withLabel: Resources.Strings.Menu.gallery)
        return button
    }()
    
    private let suggestionsButton: MenuButton = {
        let button = MenuButton()
        button.configure(withLabel: Resources.Strings.Menu.suggestions)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 0.5
        return stackView
    }()
    
    private let imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        return imagePicker
    }()
    
// MARK: - CONFIGURATIONS
    private func subscribeToViewModel() {
        viewModel.needShowImageProcessingVC
            .asObservable()
            .asDriver(onErrorJustReturn: true)
            .drive(onNext: { [unowned self] _ in
                showImageEditingController()
            })
            .disposed(by: viewModel.disposeBag)
    }
    
    private func configureButtons() {
        
//        addNavBarRightButton(ofType: .options, disposedBy: viewModel.disposeBag, completion: { [unowned self] in
//            viewModel.navBarButtonAction()
//        })
        
        suggestionsButton.setCompletion(disposedBy: viewModel.disposeBag) { [unowned self] in
            
            let suggestionsVC = SuggestionsViewController(viewModel: viewModel.viewModelForSuggestionsView)
            present(suggestionsVC, animated: true)
        }
        
//        suggestionsButton.rx.menuButoonTapped.asDriver()
//            .drive(onNext: {
//                
//            }).disposed(by: )
        
        galleryButton.setCompletion(disposedBy: viewModel.disposeBag) { [unowned self] in
            
            imagePicker.sourceType = .photoLibrary
            let imagePickerAlert = MenuImagePickerAlert { [unowned self] in
                switch $0.title {
                case Resources.Strings.Gallery.alertActionLast:
                    viewModel.prepareForLastProcessing()
                    showImageEditingController()
                    
                case Resources.Strings.Gallery.alertActionCamera:
                    imagePicker.sourceType = .camera
                    fallthrough
                
                default:
                    present(imagePicker, animated: true)
                }
            }
            present(imagePickerAlert, animated: true)
        }
    }
    
    private func showImageEditingController() {
        let destVC = ImageEditingViewController(viewModel: viewModel.viewModelForIEView)
        show(destVC, sender: nil)
    }
}

extension MenuViewController {
    
    override func setConfigurations() {
        super.setConfigurations()
        
        imagePicker.delegate = self
        
        subscribeToViewModel()
        configureButtons()
    }

// MARK: - APPEARANCE
    override func configureAppearance() {
        super.configureAppearance()
        
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        view.addSubviews(backgroundImage, stackView)
        backgroundImage.addSubviews(stickerView)
        stickerView.addSubviews(logoImView)
        
        stackView.addArrangedSubviews(galleryButton, suggestionsButton)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stickerView.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundImage.snp.bottom)
                .multipliedBy(0.6666)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
                .multipliedBy(0.6666)
            make.height.equalToSuperview()
                .multipliedBy(0.5)
        }
        
        logoImView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(33)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(stickerView.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
            make.width.equalTo(stickerView.snp.width)
        }
    }
}

// MARK: - IMAGE PICKER DELEGATE
extension MenuViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        viewModel.pickImage(selectedImage)
        imagePicker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true)
    }
}
