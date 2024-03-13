//
//  CGImage + Ext.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 13.03.24.
//

import Foundation
import CoreGraphics

extension CGImage {
    func resized(to size: CGSize) -> CGImage? {
        let width: Int = Int(size.width)
        let height: Int = Int(size.height)
        
        let bytesPerPixel = self.bitsPerPixel / self.bitsPerComponent
        let destBytesPerRow = width * bytesPerPixel
        
        
        guard let colorSpace = self.colorSpace else { 
            debugPrint(":: Error: CGImage -> resized(): Unable to get colorSpace")
            return nil }
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: self.bitsPerComponent, bytesPerRow: destBytesPerRow, space: colorSpace, bitmapInfo: self.alphaInfo.rawValue) else { 
            debugPrint(":: Error: CGImage -> resized(): Unable to get context")
            return nil }
        
        context.interpolationQuality = .high
        context.draw(self, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        return context.makeImage()
    }
}
