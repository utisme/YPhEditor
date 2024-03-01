//
//  CGImagePropertyOrientation + Ext.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 27.02.24.
//

import UIKit

extension CGImagePropertyOrientation {
    init(_ uiOrientation: UIImage.Orientation) {
        switch uiOrientation {
            case .up: self = .up
            case .upMirrored: self = .upMirrored
            case .down: self = .down
            case .downMirrored: self = .downMirrored
            case .left: self = .left
            case .leftMirrored: self = .leftMirrored
            case .right: self = .right
            case .rightMirrored: self = .rightMirrored
        @unknown default:
            self = .up
            debugPrint("WARNING: New orientation is available in UIImage.Orientation. This may produce unexpected behavior")
        }
    }
}
