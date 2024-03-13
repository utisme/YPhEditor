//
//  UserDefaultsManager.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 7.03.24.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() { debugPrint(":: Initialization UserDefaultsManager") }
    
    private let defaults = UserDefaults.standard
    private let filtersDefaultsKey = "FiltersStack"
    private let effectDefaultsKet = "Effect"
    private let settingsLanguage = "Language"
    
    private var filtersValuesDefaults: [CGFloat] {
        get {
            guard let filtersValuesDefaults = defaults.value(forKey: filtersDefaultsKey) as? [CGFloat] else {
                debugPrint(":: Error: UserDefaultsManager -> filtersValuesDefaults: Defaults value capture error")
                return [0]
            }           //TODO: handle error
            return filtersValuesDefaults
        }
        
        set {
            defaults.set(newValue, forKey: filtersDefaultsKey)
        }
    }
    
    private var effectIndexDefaults: Int? {
        get {
            defaults.value(forKey: effectDefaultsKet) as? Int
        }
        
        set {
            defaults.setValue(newValue, forKey: effectDefaultsKet)
        }
    }
    
    func setFiltersStackDefaults() {
        var filtersValues: [CGFloat] = []
        ImageProcessingManager.shared.filtersStack.forEach { filter in
            filtersValues.append(filter.value)
        }
        
        UserDefaultsManager.shared.filtersValuesDefaults = filtersValues
    }
    
    func getFiltersStackFromDefaults() {
        UserDefaultsManager.shared.filtersValuesDefaults.enumerated().forEach { index, value in
            ImageProcessingManager.shared.filtersStack[index].value = value
        }
    }
    
    func setEffectDefaults() {
        UserDefaultsManager.shared.effectIndexDefaults = ImageProcessingManager.Adjust.Effect.getEffectIndex(for: ImageProcessingManager.shared.currentEffect)
    }
    
    func getEffectFromDefaults() {
        guard let effectIndexDefaults = UserDefaultsManager.shared.effectIndexDefaults,
              let currentEffect = ImageProcessingManager.Adjust.Effect(rawValue: effectIndexDefaults)?.getEffect()
        else {
            debugPrint(":: Error: UserDefaultsManager -> getEffectFromDefaults: Guard error")
            return
        }
        
        ImageProcessingManager.shared.currentEffect = currentEffect
    }
}
