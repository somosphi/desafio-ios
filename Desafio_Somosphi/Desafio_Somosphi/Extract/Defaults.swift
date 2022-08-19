//
//  Defaults.swift
//  Desafio_Somosphi
//
//  Created by Suh on 19/08/22.
//

import Foundation

struct Defaults {
        var showAmount: Bool {
            get {
                let isEnabled = UserDefaults.standard.value(forKey: Keys.isNotificationsEnabled) as? Bool
                return isEnabled ?? true
            }
            set {
                UserDefaults.standard.setValue(newValue, forKey: Keys.isNotificationsEnabled)
            }
        }
}
