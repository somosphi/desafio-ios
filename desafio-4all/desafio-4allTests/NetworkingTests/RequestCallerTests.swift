//
//  RequestCallerTests.swift
//  desafio-4allTests
//
//  Created by Vitor Demenighi on 29/12/20.
//

import XCTest
@testable import desafio_4all

class RequestCallerTests: XCTestCase, RequestTestsDataProtocol {
    
    //MARK:- Test Requests

    //MARK: GET/myStatement
    func testMyStatementRequest() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let requestHandler = RequestHandler()
        
        session.statusCode = 200
        session.data = validStatementObject
        
        do {
            let urlRequest = try requestHandler.makeRequest(endPoint: .myStatement(offset: 1), parameters: nil).get()
            requestCaller.callRequest(urlRequest: urlRequest) { result in
                
                switch result {
                case .success(let data):
                    XCTAssertEqual(data, self.validStatementObject)
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            }
        } catch { XCTFail(error.localizedDescription) }
    }
    
    //MARK: GET/myBalance
    func testMyBalanceRequest() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let requestHandler = RequestHandler()
        
        session.statusCode = 200
        session.data = validBalanceObject
        
        do {
            let urlRequest = try requestHandler.makeRequest(endPoint: .myBalance, parameters: nil).get()
            requestCaller.callRequest(urlRequest: urlRequest) { result in
                
                switch result {
                case .success(let data):
                    XCTAssertEqual(data, self.validBalanceObject)
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            }
        } catch { XCTFail(error.localizedDescription) }
    }
    
    //MARK: GET/myStatement/detail
    func testStatementDetailRequest() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let requestHandler = RequestHandler()
        
        session.statusCode = 200
        session.data = validStatementDetailObject
        
        do {
            let urlRequest = try requestHandler.makeRequest(endPoint: .statementDetail(id: testID), parameters: nil).get()
            requestCaller.callRequest(urlRequest: urlRequest) { result in
                
                switch result {
                case .success(let data):
                    XCTAssertEqual(data, self.validStatementDetailObject)
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            }
        } catch { XCTFail(error.localizedDescription) }
    }
    
    //MARK:- Test Error Handler
    
    //MARK: Request Response Error
    func testResquestResponseError() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let requestHandler = RequestHandler()
        
        session.error = CustomError.requestResponseError
        
        do {
            let urlRequest = try requestHandler.makeRequest(endPoint: .myStatement(offset: 1), parameters: nil).get()
            requestCaller.callRequest(urlRequest: urlRequest) { result in
                
                switch result {
                case .success:
                    XCTFail()
                    
                case .failure(let error):
                    let customError = error as! CustomError
                    XCTAssertEqual(customError.localizedDescription, ErrorConstants.requestResponseError)
                }
            }
        } catch { XCTFail(error.localizedDescription) }
    }
    
    //MARK: Request Response Error Status Code 400
    func testResponseErrorStatusCode400() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let requestHandler = RequestHandler()
        let statusCode = 400
        
        session.statusCode = statusCode
        
        do {
            let urlRequest = try requestHandler.makeRequest(endPoint: .myStatement(offset: 1), parameters: nil).get()
            requestCaller.callRequest(urlRequest: urlRequest) { result in
                
                switch result {
                case .success:
                    XCTFail()
                    
                case .failure(let error):
                    let customError = error as! CustomError
                    XCTAssertEqual(customError.localizedDescription, ErrorConstants.clientError + statusCode.codeString)
                }
            }
        } catch { XCTFail(error.localizedDescription) }
    }
    
    //MARK: Request Response Error Status Code 500
    func testResponseErrorStatusCode500() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let requestHandler = RequestHandler()
        let statusCode = 500
        
        session.statusCode = statusCode
        
        do {
            let urlRequest = try requestHandler.makeRequest(endPoint: .myStatement(offset: 1), parameters: nil).get()
            requestCaller.callRequest(urlRequest: urlRequest) { result in
                
                switch result {
                case .success:
                    XCTFail()
                    
                case .failure(let error):
                    let customError = error as! CustomError
                    XCTAssertEqual(customError.localizedDescription, ErrorConstants.serverError + statusCode.codeString)
                }
            }
        } catch { XCTFail(error.localizedDescription) }
    }
    
    //MARK: Request Response Error Unknow Status Code
    func testResponseErrorStatusCodeUnknow() throws {
        let session = NetworkSessionMock()
        let requestCaller = RequestCaller(session: session)
        let requestHandler = RequestHandler()
        let statusCode = 30
        
        session.statusCode = statusCode
        
        do {
            let urlRequest = try requestHandler.makeRequest(endPoint: .myStatement(offset: 1), parameters: nil).get()
            requestCaller.callRequest(urlRequest: urlRequest) { result in
                
                switch result {
                case .success:
                    XCTFail()
                    
                case .failure(let error):
                    let customError = error as! CustomError
                    XCTAssertEqual(customError.localizedDescription, ErrorConstants.unknowCode + statusCode.codeString)
                }
            }
        } catch { XCTFail(error.localizedDescription) }
    }

}
