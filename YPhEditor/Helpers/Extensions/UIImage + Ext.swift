//
//  UIImage + Ext.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 14.02.24.
//

import UIKit

extension UIImage {
    
    func resizedTo(_ size: CGSize) -> UIImage{
        
        let renderer = UIGraphicsImageRenderer(size: size)
        let resizedImage = renderer.image { context in
            self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
        return resizedImage
    }
}
