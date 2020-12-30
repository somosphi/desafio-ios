//
//  NetworkWorkerTests.swift
//  desafio-4allTests
//
//  Created by Vitor Demenighi on 29/12/20.
//

import XCTest
@testable import desafio_4all

class NetworkWorkerTests: XCTestCase, RequestTestsDataProtocol {

    // MARK: - Test Requests
    
    // MARK: GET/myBalance Succeed Request
    func testMyBalanceSucceedRequest() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let network = NetworkWorker(requestCaller: requestCaller)
        
        session.statusCode = 200
        session.data = validBalanceObject
        
        do {
            let resultDecode = try JSONDecoder().decode(Balance.self, from: validBalanceObject!)
            
            let completion: (Result<Balance, CustomError>) -> Void = { result in
                switch result {
                case .success(let statement): XCTAssertEqual(statement.amount, resultDecode.amount)
                case .failure(let error): XCTFail(error.localizedDescription)
                }
            }
            network.performGenericRequest(endPoint: .myBalance, completion: completion)
        } catch { XCTFail(error.localizedDescription) }
    }
    
    // MARK: GET/myStatement Succeed Request
    func testMyStatementSucceedRequest() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let network = NetworkWorker(requestCaller: requestCaller)
        
        session.statusCode = 200
        session.data = validStatementObject
        
        do {
            let resultDecode = try JSONDecoder().decodeWithDate(Statement.self, from: validStatementObject!)
            
            let completion: (Result<Statement, CustomError>) -> Void = { result in
                switch result {
                case .success(let statement): XCTAssertEqual(statement.items, resultDecode.items)
                case .failure(let error): XCTFail(error.localizedDescription)
                }
            }
            network.performGenericRequest(endPoint: .myStatement(offset: 1), completion: completion)
        } catch { XCTFail(error.localizedDescription) }
    }
    
    // MARK: GET/myStatement/detail Succeed Request
    func testMyStatementDetailSucceedRequest() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let network = NetworkWorker(requestCaller: requestCaller)
        
        session.statusCode = 200
        session.data = validStatementDetailObject
        
        do {
            let resultDecode = try JSONDecoder().decodeWithDate(StatementDetail.self, from: validStatementDetailObject!)
            
            let completion: (Result<StatementDetail, CustomError>) -> Void = { result in
                switch result {
                case .success(let statementDetail): XCTAssertEqual(statementDetail, resultDecode)
                case .failure(let error): XCTFail(error.localizedDescription)
                }
            }
            network.performGenericRequest(endPoint: .statementDetail(id: testID), completion: completion)
        } catch { XCTFail(error.localizedDescription) }
    }
    
    // MARK: GET/myStatement/detail Succeed with Parameters
    func testMyStatementDetailSucceedRequestWithParameters() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let network = NetworkWorker(requestCaller: requestCaller)
        
        session.statusCode = 200
        session.data = validStatementDetailObject
        
        do {
            let resultDecode = try JSONDecoder().decodeWithDate(StatementDetail.self, from: validStatementDetailObject!)
            
            let completion: (Result<StatementDetail, CustomError>) -> Void = { result in
                switch result {
                case .success(let statementDetail): XCTAssertEqual(statementDetail, resultDecode)
                case .failure(let error): XCTFail(error.localizedDescription)
                }
            }
            network.performGenericRequest(endPoint: .statementDetail(id: testID), parameters: ["id": 1], completion: completion)
        } catch { XCTFail(error.localizedDescription) }
    }
    
    // MARK: - Test Error Handler
 
    // MARK: GET/myBalance Failed Request
    func testMyBalanceFailedRequest() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let network = NetworkWorker(requestCaller: requestCaller)
        
        session.error = CustomError.requestResponseError
        
        let completion: (Result<Statement, CustomError>) -> Void = { result in
            switch result {
            case .success: XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, ErrorConstants.requestResponseError)
            }
        }
        
        network.performGenericRequest(endPoint: .myBalance, completion: completion)
    }
    
    // MARK: GET/myStatement Failed Request
    func testMyStatementFailedRequest() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let network = NetworkWorker(requestCaller: requestCaller)
        
        session.error = CustomError.requestResponseError
        
        let completion: (Result<Statement, CustomError>) -> Void = { result in
            switch result {
            case .success: XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, ErrorConstants.requestResponseError)
            }
        }
        
        network.performGenericRequest(endPoint: .myStatement(offset: 1), completion: completion)
    }
    
    // MARK: GET/myStatement/detail Failed Request
    func testStatementDetailFailedRequest() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let network = NetworkWorker(requestCaller: requestCaller)
        
        session.error = CustomError.requestResponseError
        
        let completion: (Result<Statement, CustomError>) -> Void = { result in
            switch result {
            case .success: XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, ErrorConstants.requestResponseError)
            }
        }
        
        network.performGenericRequest(endPoint: .statementDetail(id: testID), completion: completion)
    }
    
    // MARK: Failed Parse with Data Nil
    func testFailedParserWithDataNil() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let network = NetworkWorker(requestCaller: requestCaller)
        
        session.statusCode = 200
        session.data = nil
        
        let completion: (Result<Statement, CustomError>) -> Void = { result in
            switch result {
            case .success: XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, ErrorConstants.responseDataNil)
            }
        }
        
        network.performGenericRequest(endPoint: .myStatement(offset: 1), completion: completion)
    }
    
    // MARK: Failed Parser with Invalid Object
    func testFailedParserWithInvalidObject() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let network = NetworkWorker(requestCaller: requestCaller)
        
        session.statusCode = 200
        session.data = invalidStatementObject
        
        let completion: (Result<Statement, CustomError>) -> Void = { result in
            switch result {
            case .success: XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, ErrorConstants.failedToDecode)
            }
        }
        
        network.performGenericRequest(endPoint: .myStatement(offset: 1), completion: completion)
    }
    
    // MARK: Failed Handle Invalid URL
    func testFailedHandleWithInvalidURL() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let network = NetworkWorker(requestCaller: requestCaller)
        
        let completion: (Result<Statement, CustomError>) -> Void = { result in
            switch result {
            case .success: XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, ErrorConstants.invalidURL)
            }
        }
        
        network.performGenericRequest(endPoint: .invalidPath, completion: completion)
    }
    
    // MARK: Failed Cast Response
    func testFailedCastResponse() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let network = NetworkWorker(requestCaller: requestCaller)
        
        let completion: (Result<Statement, CustomError>) -> Void = { result in
            switch result {
            case .success: XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, ErrorConstants.failedCastResponse)
            }
        }
        
        network.performGenericRequest(endPoint: .myStatement(offset: 1), completion: completion)
    }
    
    // MARK: Failed Response Error Status Code 400
    func testFailedResponseErrorStatusCode400() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let network = NetworkWorker(requestCaller: requestCaller)
        let statusCode = 400
        
        session.statusCode = statusCode
        
        let completion: (Result<Statement, CustomError>) -> Void = { result in
            switch result {
            case .success: XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, ErrorConstants.clientError + statusCode.codeString)
            }
        }
 
        network.performGenericRequest(endPoint: .myStatement(offset: 1), completion: completion)
    }
    
    // MARK: Failed Response Error Status Code 500
    func testFailedResponseErrorStatusCode500() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let network = NetworkWorker(requestCaller: requestCaller)
        let statusCode = 500
        
        session.statusCode = statusCode
        
        let completion: (Result<Statement, CustomError>) -> Void = { result in
            switch result {
            case .success: XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, ErrorConstants.serverError + statusCode.codeString)
            }
        }
        
        network.performGenericRequest(endPoint: .myStatement(offset: 1), completion: completion)
    }
    
    // MARK: Failed Response Error Unknow Status Code
    func testFailedResponseErrorUnknowStatusCode() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let network = NetworkWorker(requestCaller: requestCaller)
        let statusCode = 30
        
        session.statusCode = statusCode
        
        let completion: (Result<Statement, CustomError>) -> Void = { result in
            switch result {
            case .success: XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, ErrorConstants.unknowCode + statusCode.codeString)
            }
        }
        
        network.performGenericRequest(endPoint: .myStatement(offset: 1), completion: completion)
    }
}


