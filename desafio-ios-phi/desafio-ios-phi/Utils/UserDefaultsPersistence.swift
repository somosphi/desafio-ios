//
//  Persistence.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 03/05/21.
//

import Foundation
struct UserDefaultsPersistence {
    static var shared = UserDefaultsPersistence()
    private let standard = UserDefaults.standard
    
    func setupUserPreference() {
        if standard.object(forKey: ISAMOUNTHIDDEN) == nil {
            standard.setValue(false, forKey: ISAMOUNTHIDDEN)
        }
    }
    
    func getIsAmountHidden() -> Bool {
        return standard.bool(forKey: ISAMOUNTHIDDEN)
    }
    
    func setIsAmountHidden(value: Bool) {
        standard.setValue(value, forKey: ISAMOUNTHIDDEN)
    }
}
