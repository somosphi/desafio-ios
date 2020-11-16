//
//  DetailsDoubles.swift
//  PhiChallengeTests
//
//  Created by Felipe Wilke on 16/11/20.
//


import Foundation

@testable import PhiChallenge

final class DetailsScreenViewSpy: DetailsScreenView {
    
    private(set) var showLoaderCalled = false
    
    func showLoader() {
        showLoaderCalled = true
    }
    private(set) var hideLoaderCalled = false
    
    func hideLoader() {
        hideLoaderCalled = true
    }
    
    private(set) var showErrorCalled = false
    private(set) var showErrorPassed: String?
    
    func showError(message: String) {
        showErrorCalled = true
        showErrorPassed = message
    }
    
    private(set) var setAmountCalled = false
    private(set) var setAmountPassed: String?
    
    func setAmount(with text: String) {
        setAmountCalled = true
        setAmountPassed = text
    }
    
    private(set) var setReceiverCalled = false
    private(set) var setReceiverPassed: String?
    
    func setReceiver(with text: String) {
        setReceiverCalled = true
        setReceiverPassed = text
    }
    private(set) var setDescriptionCalled = false
    private(set) var setDescriptionPassed: String?
    
    func setDescription(with text: String) {
        setDescriptionCalled = true
        setDescriptionPassed = text
    }
    
    private(set) var setBankNameCalled = false
    private(set) var setBankNamePassed: String?
    
    func setBankName(with text: String) {
        setBankNameCalled = true
        setBankNamePassed = text
    }
    
    private(set) var setAuthenticationCalled = false
    private(set) var setAuthenticationPassed: String?
    
    func setAuthentication(with text: String) {
        setAuthenticationCalled = true
        setAuthenticationPassed = text
    }
    
    private(set) var setCreatedAtCalled = false
    private(set) var setCreatedAtPassed: String?
    
    func setCreatedAt(with text: String) {
        setCreatedAtCalled = true
        setCreatedAtPassed = text
    }
}

final class DetailsServiceSpy: DetailsServiceInput {
    var outputDetails: DetailsServiceOutput?
    
    private(set) var fetchStatementIDCalled = false
    private(set) var fetchStatementIDPassed: String?
    func fetchStatementID(id: String) {
        fetchStatementIDCalled = true
        fetchStatementIDPassed = id
    }
    
    
    
    
}
