//
//  StatementItemTests.swift
//  desafio-4allTests
//
//  Created by Vitor Demenighi on 03/01/21.
//

import XCTest

class StatementItemTests: XCTestCase {
    
    // MARK: - Mock Variables

    let statamentItem1 = Item(id: "", amount: 1200, description: "Transferência Realizada Pix", tType: "TRANSOUTPIX", from: "Pedro", to: "Diego", bankName: "Banco Phi", createdAt: Date())
    
    let statamentItem2 = Item(id: "", amount: 890, description: "Transferência Realizada", tType: nil, from: nil, to: "Diego", bankName: "Banco Phi", createdAt: Date())
    
    // MARK: - Test Statement Detail Functions
    
    func testIsTransferOutFunction() throws {
        XCTAssertEqual(statamentItem1.isTransferOut(), true)
        XCTAssertEqual(statamentItem2.isTransferOut(), false)
    }
    
    func testGetCorrectlyAmountFunction() throws {
        XCTAssertEqual(statamentItem1.getCorrectlyAmount(), -1200)
        XCTAssertEqual(statamentItem2.getCorrectlyAmount(), 890)
    }
    
    func testGetCorrectlyFromStringFunction() throws {
        XCTAssertEqual(statamentItem1.getCorrectlyFromString(), "Pedro")
        XCTAssertEqual(statamentItem2.getCorrectlyFromString(), StringConstants.yourAccount)
    }
    
    func testIsPixFunction() throws {
        XCTAssertEqual(statamentItem1.isPix(), true)
        XCTAssertEqual(statamentItem2.isPix(), false)
    }

}
