//
//  Resources.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 31.01.24.
//

import Foundation
import UIKit

struct Resources {
    
// MARK: - STRINGS
    enum Strings {
        
        enum Menu {
            
            static let gallery = "Gallery".localized()
            static let suggestions = "Suggestions".localized()
        }
    }

// MARK: - IMAGES
    enum Images {
        
        enum Menu {
            
            static let background = UIImage(named: "menuBackground")
            static let sticker = UIImage(named: "sticker")
            static let logo = UIImage(named: "logo")
        }
    }
    
// MARK: - COLORS
    enum Colors {
        
        static let background = UIColor(named: "background")
        static let element = UIColor(named: "element")
        static let elementGray = UIColor(named: "elementGray")
    }
    
// MARK: FONTS
    enum Fonts {
        
        static func helveticaRegular(withSize size: CGFloat) -> UIFont? {
            UIFont(name: "Helvetica", size: size)
        }
    }
}


