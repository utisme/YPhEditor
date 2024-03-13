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
            static let alertActionLast = "Last Image".localized()
            static let alertActionCancel = "Cancel".localized()
        }
        
        enum ImageEditing {
            
            enum Uploding {
                
                static let copyButton = "Copy Link".localized()
                static let cancelButton = "Cancel".localized()
            }
            
            enum Info {
                
                static let noDataLeft = "There is nothing here...".localized()
                static let noDataRight = "And here".localized()
            }
        }
        
        enum Settings {
            
            static let language = "Language: ".localized()
        }
    }

// MARK: - IMAGES
    enum Images {
        
        static let imageError: UIImage! = UIImage(named: "noImage")
        
        enum NavBar {
            
            static let back = UIImage(systemName: "chevron.left")
            static let options = UIImage(systemName: "ellipsis.circle.fill")
            static let info = UIImage(systemName: "info.circle.fill")
            static let download = UIImage(systemName: "square.and.arrow.down.fill")
            static let upload = UIImage(systemName: "icloud.and.arrow.up.fill")
            static let ai: UIImage! = UIImage(named: "papricaIcon")
        }
        
        enum Menu {
            
            static let background: UIImage! = UIImage(named: "menuBackground")
            static let sticker = UIImage(named: "sticker")
            static let logo = UIImage(named: "logo")
        }
        
        enum Suggestions {
            
            static let downArrow = UIImage(systemName: "chevron.compact.down")
        }
        
        enum ImageEditing {
            
            enum ToolBar {
                
                static let backward = UIImage(systemName: "arrowshape.turn.up.backward")
                static let filters = UIImage(systemName: "dial.low.fill")
                static let effects = UIImage(systemName: "camera.filters")
                static let forward = UIImage(systemName: "arrowshape.turn.up.forward")
            }
            
            enum Filters {
                
                static let exposure = UIImage(systemName: "plusminus.circle")
                static let gamma = UIImage(systemName: "sun.max")
                static let saturation = UIImage(named: "saturation")
                static let contrast = UIImage(systemName: "circle.lefthalf.filled")
                static let brightness = UIImage(systemName: "sun.min.fill")
                static let vibrance = UIImage(named: "vibrance")
                static let tint = UIImage(systemName: "drop")
            }
        }
    }
    
// MARK: - COLORS
    enum Colors {
        
        static let background = UIColor(named: "background")
        static let element = UIColor(named: "element")
        static let elementGray = UIColor(named: "elementGray")
        static let elementYellow = UIColor(named: "elementYellow")
        static let elementYellowSelected = UIColor(named: "elementYellow")?.withAlphaComponent(0.2)
    }
    
// MARK: FONTS
    enum Fonts {
        
        static func helveticaRegular(withSize size: CGFloat) -> UIFont? {
            UIFont(name: "Helvetica", size: size)
        }
    }
}


