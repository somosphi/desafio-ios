//
//  StatementCellDoubles.swift
//  PhiChallengeTests
//
//  Created by Felipe Wilke on 15/11/20.
//

import Foundation

@testable import PhiChallenge

final class StatementCellViewSpy: StatementCellView {
 
    private(set) var setDescriptionCalled = false
    private(set) var setDescriptionPassed: String?
    
    func setDescription(with text: String) {
        
        setDescriptionCalled = true
        setDescriptionPassed = text
    }
    
    private(set) var setReceiverCalled = false
    private(set) var setReceiverPassed: String?
    
    func setReceiver(with text: String) {
        setReceiverCalled = true
        setReceiverPassed = text
    }
    
    private(set) var setAmountCalled = false
    private(set) var setAmountPassed: String?
    
    func setAmount(with text: String) {
        setAmountCalled = true
        setAmountPassed = text
    }
    
    private(set) var setCreatedAtCalled = false
    private(set) var setCreatedAtPassed: String?
    
    func setCreatedAt(with text: String) {
        setCreatedAtCalled = true
        setCreatedAtPassed = text
    }
    
    private(set) var showPixFlagCalled = false
    private(set) var showPixFlagPassed: Bool?
    
    func showPixFlag(with flag: Bool) {
        showPixFlagCalled = true
        showPixFlagPassed = flag
    }
    
    
    
}
