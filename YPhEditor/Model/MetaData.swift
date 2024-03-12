//
//  MetaData.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 11.03.24.
//

import Foundation

struct MetaData: Decodable {
    
    enum FirstContainerKeys: String, CodingKey {
        case colorSpace = "ColorModel", exif = "{Exif}"
    }
    
    enum SecondContainerKeys: String, CodingKey {
        case pixelXDim = "PixelXDimension"
        case pixelYDim = "PixelYDimension"
    }
    
    let colorSpace: String
    let pixelXDim: String
    let pixelYDim: String
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: FirstContainerKeys.self)
        let exifContainer = try rootContainer.nestedContainer(keyedBy: SecondContainerKeys.self, forKey: .exif)
        
        self.colorSpace = try rootContainer.decode(String.self, forKey: .colorSpace)
        self.pixelXDim = try exifContainer.decode(String.self, forKey: .pixelXDim)
        self.pixelYDim = try exifContainer.decode(String.self, forKey: .pixelYDim)
    }
}
