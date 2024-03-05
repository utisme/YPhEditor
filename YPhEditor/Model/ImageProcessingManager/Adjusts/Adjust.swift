//
//  Adjust.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 4.03.24.
//

import Foundation

extension ImageProcessingManager {
    enum Adjust {
        case filters, effects
        
        mutating func seftSwitch() {
            switch self {
            case .filters:
                self = .effects
            case .effects:
                self = .filters
            }
        }
    }
}
