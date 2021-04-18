//
//  UserSettingsTest.swift
//  DesafioIOSTests
//
//

import XCTest
@testable import DesafioIOS

class UserSettingsTest: XCTestCase {
    
    var userSettings = UserSettings.shared
    
    override class func setUp() {
        // reset defaults
        let defaults = UserDefaults.standard
           let dictionary = defaults.dictionaryRepresentation()
           dictionary.keys.forEach { key in
               defaults.removeObject(forKey: key)
           }
    }

    func testDefaultShowBalanceValueIsFalse(){
        XCTAssertFalse(userSettings.showBalance)
    }
    
}
