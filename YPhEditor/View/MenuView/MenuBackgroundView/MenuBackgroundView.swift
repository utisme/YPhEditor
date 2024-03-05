//
//  MenuBackgroundView.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 22.02.24.
//

import UIKit
import MetalKit

final class MenuBackgroundView: BaseView {
    
    private let viewModel: MenuBackgroundViewModelProtocol = MenuBackgroundViewModel()
    
    private let backgroundImage: MetalImageView = {
        let metalImageView = MetalImageView(frame: .zero)
        metalImageView.setTexture(from: Resources.Images.Menu.background.cgImage)
        return metalImageView
    }()
}

extension MenuBackgroundView {
    
    override func setConfigurations() {
        super.setConfigurations()
//      TODO: lazy var
        backgroundImage.delegate = self
    }
    
    override func configureAppearance() {
        
    }
    
    override func setupSubviews() {
        super.setupSubviews()           // TODO: подумать нужен ли супер
        
        addSubviews(backgroundImage)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MenuBackgroundView: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
    
    func draw(in view: MTKView) {
        
        guard let view = view as? MetalImageView,
              let currentDrawable = view.currentDrawable,
              let sourceTexture = view.sourceTexture,
              let commandBuffer = view.commandQueue.makeCommandBuffer(),
              let image = CIImage(mtlTexture: sourceTexture)
        else { return }
        
        let processedImage = viewModel.prepareImage(image, to: view)
        
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
