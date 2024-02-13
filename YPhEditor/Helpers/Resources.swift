//
//  Resources.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 31.01.24.
//
// посмотреть на swiftGen

import Foundation
import UIKit

struct Resources {
    
// MARK: - STRINGS
    enum Strings {
        
        enum Menu {
            
            static let gallery = "Gallery".localized()
            static let suggestions = "Suggestions".localized()
        }
        
        enum Gallery {
            
            static let alertTitle = "Import an image from: ".localized()
            static let alertActionGallery = "Gallery".localized()
            static let alertActionCamera = "Camera".localized()
            static let alertActionCancel = "Cancel".localized()
        }
    }

// MARK: - IMAGES
    enum Images {
        
        enum Menu {
            
            static let background = UIImage(named: "menuBackground")
            static let sticker = UIImage(named: "sticker")
            static let logo = UIImage(named: "logo")
        }
        
        enum Suggestions {
            static let downArrow = UIImage(systemName: "chevron.compact.down")
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


