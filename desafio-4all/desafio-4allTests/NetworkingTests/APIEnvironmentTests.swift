//
//  APIEnvironmentTests.swift
//  desafio-4allTests
//
//  Created by Vitor Demenighi on 29/12/20.
//

import XCTest
@testable import desafio_4all

class APIEnvironmentTests: XCTestCase, RequestTestsDataProtocol {
    
    //MARK: myBalance Endpoint
    func testMyBalanceEndpoint() throws {
        XCTAssertEqual(Endpoint.myBalance.parameters.path, "myBalance")
        XCTAssertEqual(Endpoint.myBalance.parameters.method, .get)
        XCTAssertEqual(Endpoint.myBalance.parameters.isAuth, true)
        XCTAssertEqual(Endpoint.myBalance.completePath, "https://desafio-mobile-bff.herokuapp.com/myBalance")
    }

    //MARK: myStatement Endpoint
    func testMyStatementEndpoint() throws {
        let offset = 1
        XCTAssertEqual(Endpoint.myStatement(offset: offset).parameters.path, "myStatement/10/1")
        XCTAssertEqual(Endpoint.myStatement(offset: offset).parameters.method, .get)
        XCTAssertEqual(Endpoint.myStatement(offset: offset).parameters.isAuth, true)
        XCTAssertEqual(Endpoint.myStatement(offset: offset).completePath, "https://desafio-mobile-bff.herokuapp.com/myStatement/10/1")
    }
    
    //MARK: statementDetail Endpoint
    func testStatementDetailEndpoint() throws {
        XCTAssertEqual(Endpoint.statementDetail(id: testID).parameters.path, "myStatement/detail/\(testID)/")
        XCTAssertEqual(Endpoint.statementDetail(id: testID).parameters.method, .get)
        XCTAssertEqual(Endpoint.statementDetail(id: testID).parameters.isAuth, true)
        XCTAssertEqual(Endpoint.statementDetail(id: testID).completePath, "https://desafio-mobile-bff.herokuapp.com/myStatement/detail/\(testID)/")
    }
    

}
