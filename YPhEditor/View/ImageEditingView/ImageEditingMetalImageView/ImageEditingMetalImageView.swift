//
//  ImageEditingMetalImageView.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 22.02.24.
//

import UIKit
import MetalKit

final class ImageEditingMetalImageView: BaseView {
    
    private let viewModel: ImageEditingMetalImageViewModelProtocol
    
    private let backgroundImage = MetalImageView()
    
    init(viewModel: ImageEditingMetalImageViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) { nil }
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
              let commandBuffer = view.commandQueue.makeCommandBuffer(),
              let image = CurrentImageManager.shared.currentCIImage,
              let orientation = CurrentImageManager.shared.currentUIImage?.imageOrientation
        else { return }
        
        let scaledToViewImage = viewModel.prepareImage(image.oriented(CGImagePropertyOrientation(orientation)),
                                                       to: view)
        
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
