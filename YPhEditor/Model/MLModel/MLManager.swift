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
//    let paprikaModel: Paprika
    
    private init() {
        debugPrint(":: MLManager initialization")
        guard let AESRNetModel = try? AESRNet(configuration: MLModelConfiguration()),
              let paprikaModel = try? Paprika(configuration: MLModelConfiguration())
        else { fatalError("Unable to init MLManager") }
        
        self.AESRNetModel = AESRNetModel
//        self.paprikaModel = paprikaModel
    }
    
    func AESRNetModelPredictFor(_ image: CGImage?) -> CGImage? {
        
        guard let image,
              let prediction = try? AESRNetModel.prediction(input: AESRNetInput(inputWith: image)) 
        else {
            debugPrint(":: Error: MLManager -> AESRNetModelPredictFor: AESRNet applying error")
            return nil }
        
        let ciImage = CIImage(cvPixelBuffer: prediction.activation_out)
        let cgImage = ImageProcessingManager.shared.ciContext.createCGImage(ciImage, from: ciImage.extent)
        return cgImage
    }
    
    func paprikaModelPredictFor(_ image: CGImage?) -> CGImage? {
        
        guard let image,
              let paprikaModel = try? Paprika(configuration: MLModelConfiguration()),
              let prediction = try? paprikaModel.prediction(input: PaprikaInput(test__0With: image))
        else {
            debugPrint(":: Error: MLManager -> paprikaModelPredictFor: Paprika applying error")
            return nil }
        
        let ciImage = CIImage(cvPixelBuffer: prediction.image)
        let cgImage = ImageProcessingManager.shared.ciContext.createCGImage(ciImage, from: ciImage.extent)
        return cgImage
    }
}
