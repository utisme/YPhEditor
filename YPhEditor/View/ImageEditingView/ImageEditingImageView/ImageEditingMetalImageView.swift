//
//  ImageEditingMetalImageView.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 22.02.24.
//

import UIKit
import MetalKit

final class ImageEditingMetalImageView: BaseView {
    
    private let viewModel: ImageEditingMetalImageViewModelProtocol = ImageEditingMetalImageViewModel()
    
    private let backgroundImage = MetalImageView()
}

extension ImageEditingMetalImageView {
    
    override func setConfigurations() {
        super.setConfigurations()
        
        backgroundImage.delegate = self
        backgroundImage.setTexture(from: viewModel.getCurrentImage())
    }
    
    override func configureAppearance() {
        
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubviews(backgroundImage)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ImageEditingMetalImageView: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
    
    func draw(in view: MTKView) {
        
        guard let view = view as? MetalImageView,
              let currentDrawable = view.currentDrawable,
              let sourceTexture = view.sourceTexture,
              let commandBuffer = view.commandQueue.makeCommandBuffer(),
              let image = CIImage(mtlTexture: sourceTexture)
        else { return }
        
        let scaledToViewImage = viewModel.prepareImage(image, to: view)
        
        let bounds = CGRect(x: 0, y: 0, width: view.drawableSize.width, height: view.drawableSize.height)
        view.context.render(scaledToViewImage,
                            to: currentDrawable.texture,
                            commandBuffer: commandBuffer,
                            bounds: bounds,
                            colorSpace: view.colorSpace)
        commandBuffer.present(currentDrawable)
        commandBuffer.commit()
    }
}
