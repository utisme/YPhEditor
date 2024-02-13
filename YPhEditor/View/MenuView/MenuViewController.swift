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
    var viewModel: MenuViewModelProtocol = MenuViewModel()
    
    private let backgroundImage: MetalImageView = {
        let metalImageView = MetalImageView(frame: .zero)
        metalImageView.setTexture(from: Resources.Images.Menu.background)
        return metalImageView
    }()
    
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
    func subscribeToViewModel() {
        viewModel.needShowImageProcessingVC
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                let destVC = ImageEditingViewController()
                self?.navigationController?.pushViewController(destVC, animated: true)
            })
            .disposed(by: viewModel.disposeBag)
    }
    
    func configureButtons() {
        
        addNavBarButton(ofType: .options, disposedBy: viewModel.disposeBag, completion: { [unowned self] in
            viewModel.navBarButtonAction()
        })
        
        suggestionsButton.setCompletion(disposedBy: viewModel.disposeBag) { [unowned self] in
            
            let suggestionsVC = SuggestionsViewController()
            suggestionsVC.viewModel = viewModel.getSuggestionsViewModel()
            showDetailViewController(suggestionsVC, sender: self)
        }
        
        galleryButton.setCompletion(disposedBy: viewModel.disposeBag) { [unowned self] in
            
            imagePicker.sourceType = .photoLibrary
            let imagePickerAlert = ImagePickerAlert { [unowned self] in
                if $0.title == Resources.Strings.Gallery.alertActionCamera {
                    imagePicker.sourceType = .camera
                }
                present(imagePicker, animated: true)
            }
            present(imagePickerAlert, animated: true)
        }
    }
}

extension MenuViewController {
    
    override func configure() {
        super.configure()
        
        backgroundImage.delegate = self
        
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

// MARK: - MTKView DELEGATE

extension MenuViewController: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
    
    func draw(in view: MTKView) {
        
        guard let view = view as? MetalImageView,
              let currentDrawable = view.currentDrawable,
              let sourceTexture = view.sourceTexture,
              let commandBuffer = view.commandQueue.makeCommandBuffer(),
              let image = CIImage(mtlTexture: sourceTexture)
        else { return }
        
        let processedImage = viewModel.prepareImageForBackground(image, to: view)
        
        let bounds = CGRect(x: 0, y: 0, width: view.drawableSize.width, height: view.drawableSize.height)
        view.context.render(processedImage,
                            to: currentDrawable.texture,
                            commandBuffer: commandBuffer,
                            bounds: bounds,
                            colorSpace: view.colorSpace)
        commandBuffer.present(currentDrawable)
        commandBuffer.commit()
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
