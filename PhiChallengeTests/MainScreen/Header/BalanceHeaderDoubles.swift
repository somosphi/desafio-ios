//
//  BalanceHeaderDoubles.swift
//  PhiChallengeTests
//
//  Created by Felipe Wilke on 15/11/20.
//

import Foundation

@testable import PhiChallenge

final class BalanceHeaderViewSpy: BalanceHeaderView {
    
    private(set) var setAmountCalled = false
    private(set) var setAmountPassed: String?
    
    func setAmount(with text: String) {
        setAmountCalled = true
        setAmountPassed = text
    }
    
    private(set) var hideAmountCalled = false
    private(set) var hideAmountFlagPassed: Bool?
    private(set) var hideAmountImagePassed: String?
    
    func hideAmount(with flag: Bool, image: String) {
        hideAmountCalled = true
        hideAmountFlagPassed = flag
        hideAmountImagePassed = image
    }
}
