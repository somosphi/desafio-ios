//
//  StatementDetailTests.swift
//  desafio-4allTests
//
//  Created by Vitor Demenighi on 03/01/21.
//

import XCTest

class StatementDetailTests: XCTestCase {
    
    // MARK: - Mock Variables
    
    let statamentDetail1 = StatementDetail(amount: 478, id: "", authentication: nil, tType: "TRANSOUT", createdAt: Date(), to: "Carlos", description: "Transferência Realizada", bankName: "Banco Phi")
    
    let statamentDetail2 = StatementDetail(amount: 2432, id: "", authentication: nil, tType: nil, createdAt: Date(), to: nil, description: "Transferência Realizada", bankName: nil)
    
    // MARK: - Test Statement Item Functions
    
    func testIsTransferOutFunction() throws {
        XCTAssertEqual(statamentDetail1.isTransferOut(), true)
        XCTAssertEqual(statamentDetail2.isTransferOut(), false)
    }
    
    func testGetCorrectlyAmountFunction() throws {
        XCTAssertEqual(statamentDetail1.getCorrectlyAmount(), -478)
        XCTAssertEqual(statamentDetail2.getCorrectlyAmount(), 2432)
    }
    
    func testGetCorrectlyFromStringFunction() throws {
        XCTAssertEqual(statamentDetail1.getCorrectlyFromString(), "Carlos")
        XCTAssertEqual(statamentDetail2.getCorrectlyFromString(), StringConstants.yourAccount)
    }
}
