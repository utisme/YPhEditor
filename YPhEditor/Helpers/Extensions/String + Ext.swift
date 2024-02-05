//
//  String + Ext.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 31.01.24.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
