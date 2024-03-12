//
//  MLManager.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 12.03.24.
//

import Foundation
import CoreML
import CoreImage
import UIKit

final class MLManager {
    
    static let shared = MLManager()
    
    let AESRNetModel: AESRNet
    let paprikaModel: Paprika
    
    private init() {
        guard let AESRNetModel = try? AESRNet(configuration: MLModelConfiguration()),
              let paprikaModel = try? Paprika(configuration: MLModelConfiguration())
        else { fatalError() }           //TODO: handle error
        
        self.AESRNetModel = AESRNetModel
        self.paprikaModel = paprikaModel
    }
    
    func AESRNetModelPredictFor(_ image: CGImage?) -> CGImage? {
        
        guard let image,
              let prediction = try? AESRNetModel.prediction(input: AESRNetInput(inputWith: image)) else { return nil }          //TODO: handle error
        
        let ciImage = CIImage(cvPixelBuffer: prediction.activation_out)
        let cgImage = ImageProcessingManager.shared.ciContext.createCGImage(ciImage, from: ciImage.extent)
        return cgImage
    }
    
    func paprikaModelPredictFor(_ image: CGImage?) -> CGImage? {
        guard let image,
              let prediction = try? paprikaModel.prediction(input: PaprikaInput(test__0With: image)) else { return nil }          //TODO: handle error
        
        let ciImage = CIImage(cvPixelBuffer: prediction.image)
        let cgImage = ImageProcessingManager.shared.ciContext.createCGImage(ciImage, from: ciImage.extent)
        return cgImage
    }
}
