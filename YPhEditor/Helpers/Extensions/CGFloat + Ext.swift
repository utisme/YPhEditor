//
//  CGFloat + Ext.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 15.02.24.
//

import Foundation

extension CGFloat {
    func rounded(to number: CGFloat) -> CGFloat {
        guard number > 0 else { return self }
        
        let value: CGFloat = pow(CGFloat(10), number)
        return (self * value).rounded() / value
    }
}
