//
//  MyStatementViewModelTest.swift
//  DesafioIOSTests
//
//

import XCTest
import Combine
@testable import DesafioIOS



class MyStatementViewModelTest: XCTestCase {
    
    private let noBreakSpace = "\u{A0}"
    
    func testFetchBalanceSuccess() throws {
        // Given
        let apiCallerSuccessMock = ApiCallerSuccessMock()
        let viewModel = MyStatementViewModel(apiCaller: apiCallerSuccessMock)
        
        // When
        let myBalanceResultReceived = self.waitForFunctionCall(
            function: viewModel.fetchBalance,
            resultsObservable: viewModel.myBalanceObservable)
        
        // Then
        let expectedBalance = MyBalance(value: "R$\(noBreakSpace)\(apiCallerSuccessMock.myBalance),00")
        
        switch myBalanceResultReceived {
            case .success(let myBalance):
                XCTAssertEqual(myBalance, expectedBalance)
            default:
                XCTFail()
        }
    }
    
    func testFetchBalanceError() throws {
        // Given
        let viewModel = MyStatementViewModel(apiCaller: ApiCallerErrorMock())
        
        // When
        let myBalanceResultReceived = self.waitForFunctionCall(
            function: viewModel.fetchBalance,
            resultsObservable: viewModel.myBalanceObservable)
        // Then
        switch myBalanceResultReceived {
            case .failure(let error):
                XCTAssertEqual(error, .loadBalanceError)
            default:
                XCTFail()
        }
    }
    
    func testFetchStatementsSuccess() throws {
        // Given
        let apiCallerSuccessMock = ApiCallerSuccessMock()
        let viewModel = MyStatementViewModel(apiCaller: apiCallerSuccessMock)
        
        // When
        let mystatementItemsResult = waitForFunctionCall(
            function: viewModel.fetchStatements,
            resultsObservable: viewModel.statementItemsObservable)
        
        // Then
        let expectedItems = apiCallerSuccessMock.myStatementResponse.items.map{statementResponse in
            MyStatementItem(statementResponse: statementResponse,
                                         statementDateFormatter: StatementDateFormatter.shared,
                                         moneyFormatter: MoneyFormatter.shared)
        }
        
        switch mystatementItemsResult {
            case .success(let statementItems):
                XCTAssertEqual(statementItems, expectedItems)
            default:
                XCTFail()
        }
    }
    
    
    
    func testFetchStatementsError() throws {
        // Given
        let viewModel = MyStatementViewModel(apiCaller: ApiCallerErrorMock())
        
        
        // When
        let mystatementItemsResult = self.waitForFunctionCall(
            function: viewModel.fetchStatements,
            resultsObservable: viewModel.statementItemsObservable)
        
        // Then
        switch mystatementItemsResult {
            case .failure(let error):
                XCTAssertEqual(error, .loadStatementsError)
            default:
                XCTFail()
        }
    }
    
}

private class ApiCallerErrorMock : ApiCallerProtocol{
    
    enum ApiCallerError : Error{
        case myBalanceError
        case myStatementError
        case myStatementDetailError
    }
    
    func fetchMyBalance(completion: @escaping (Result<MyBalanceResponse, Error>) -> Void) {
        completion(.failure(ApiCallerError.myBalanceError))
    }
    
    func fetchMyStatement(numberOfItems: Int, offset: Int, completion: @escaping (Result<MyStatetementsResponse, Error>) -> Void) {
        completion(.failure(ApiCallerError.myStatementError))
    }
    
    func fetchMyStatementDetail(id: String, completion: @escaping (Result<MyStatetementDetailResponse, Error>) -> Void) {
        completion(.failure(ApiCallerError.myStatementDetailError))
    }
    
    
}

private class ApiCallerSuccessMock : ApiCallerProtocol{
    
    let myBalance  = 100
    
    
    let myStatementResponse = MyStatetementsResponse(
        items: [
            MyStatetmentResponse(
                id: "1",
                createdAt: ISO8601DateFormatter().string(from: Date()),
                tType: PixType.PIXCASHIN.rawValue,
                amount: 100,
                to: "someone",
                bankName: "algum banco",
                description: "description"),
            MyStatetmentResponse(
                id: "2",
                createdAt: ISO8601DateFormatter().string(from: Date()),
                tType: "Nao pix",
                amount: 200,
                to: "other someone",
                bankName: "algum outro banco",
                description: "alguma description")
        ])
    
    
    func fetchMyBalance(completion: @escaping (Result<MyBalanceResponse, Error>) -> Void) {
        completion(.success(MyBalanceResponse(amount: Double(myBalance))))
    }
    
    func fetchMyStatement(numberOfItems: Int, offset: Int, completion: @escaping (Result<MyStatetementsResponse, Error>) -> Void) {
        completion(.success(myStatementResponse))
    }
    
    func fetchMyStatementDetail(id: String, completion: @escaping (Result<MyStatetementDetailResponse, Error>) -> Void) {
    }

}
