//
//  MenuViewController.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 31.01.24.
//

import UIKit
import MetalKit

class MenuViewController: BaseViewController {
    
    var viewModel: MenuViewModelProtocol? = MenuViewModel()
    
    let backgroundImage: MetalImageView = {
        let metalImageView = MetalImageView(frame: .zero)
        metalImageView.setTexture(from: Resources.Images.Menu.background)
        return metalImageView
    }()
    
    let stickerView: UIImageView = {
        let stickerView = UIImageView()
        stickerView.image = Resources.Images.Menu.sticker
        stickerView.contentMode = .scaleToFill
        return stickerView
    }()
    
    let logoImView: UIImageView = {
        let logo = UIImageView()
        logo.image = Resources.Images.Menu.logo
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    let galleryButton: MenuButton = {
        let button = MenuButton()
        button.configure(withLabel: Resources.Strings.Menu.gallery)
        return button
    }()
    
    let suggestionsButton: MenuButton = {
        let button = MenuButton()
        button.configure(withLabel: Resources.Strings.Menu.suggestions)
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 0.5
        return stackView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        addNavBarButton(ofType: .options, action: nil)
        
        backgroundImage.delegate = self
    }
}

// MARK: - APPEARANCE

extension MenuViewController {
    override func configureAppearance() {
    }
    
    override func setupSubviews() {
        
        view.addSubviews(backgroundImage, stackView)
        backgroundImage.addSubviews(stickerView)
        stickerView.addSubviews(logoImView)
        
        stackView.addArrangedSubview(galleryButton)
        stackView.addArrangedSubview(suggestionsButton)
    }
    
    override func constraintSubviews() {
        
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
        
        if let processedImage = viewModel?.prepareImage(image, to: view) {
            
            let bounds = CGRect(x: 0, y: 0, width: view.drawableSize.width, height: view.drawableSize.height)
            view.context.render(processedImage,
                                to: currentDrawable.texture,
                                commandBuffer: commandBuffer,
                                bounds: bounds,
                                colorSpace: view.colorSpace)
            commandBuffer.present(currentDrawable)
        }
        commandBuffer.commit()
    }
}



