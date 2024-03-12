//
//  UserDefaultsManager.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 7.03.24.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() { }
    
    private let defaults = UserDefaults.standard
    private let filtersDefaultsKey = "FiltersStack"
    private let effectDefaultsKet = "Effect"
    private let settingsLanguage = "Language"
    
    var filtersValuesDefaults: [CGFloat] {
        get {
            guard let filtersValuesDefaults = defaults.value(forKey: filtersDefaultsKey) as? [CGFloat] else { return [0] }           //TODO: handle error
            return filtersValuesDefaults
        }
        
        set {
            defaults.set(newValue, forKey: filtersDefaultsKey)
        }
    }
    
    var effectIndexDefaults: Int? {
        get {
            defaults.value(forKey: effectDefaultsKet) as? Int
        }
        
        set {
            defaults.setValue(newValue, forKey: effectDefaultsKet)
        }
    }
    
    
}
