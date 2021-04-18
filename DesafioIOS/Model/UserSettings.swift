//
//  File.swift
//  DesafioIOS
//
//

import Foundation

enum UserSettingsKeys : String{
    case showBalanceKey
}

// https://www.swiftbysundell.com/articles/property-wrappers-in-swift/
class UserSettings{
    
    static let shared = UserSettings()
    
    private init(){}
    
    @UserDefaultsWrapper<Bool>(key : UserSettingsKeys.showBalanceKey.rawValue, defaultValue : false)
    var showBalance : Bool
    
}
