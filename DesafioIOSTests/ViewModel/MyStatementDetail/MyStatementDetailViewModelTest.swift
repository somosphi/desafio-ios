//
//  MyStatementDetailViewModelTest.swift
//  DesafioIOSTests
//
//

import XCTest
import Combine
@testable import DesafioIOS


class MyStatementDetailViewModelTest: XCTestCase {
    
    func testFetchFetchStatementDetailSuccess(){
        // Given
        let apiCallerSuccessMock = ApiCallerSuccessMock()
        let myStatementDetailViewModel = MyStatementDetailViewModel(apiCaller: apiCallerSuccessMock, statementId: "some id")

        // When
        let result = waitForFunctionCall(function: myStatementDetailViewModel.fetchStatementDetail,
                                         resultsObservable: myStatementDetailViewModel.itemDetailObservable)
        
        // Then
        let expectedResult = MyStatementDetail(
            myStatementDetailResponse: apiCallerSuccessMock.detailResponse,
            moneyFormatter: MoneyFormatter.shared,
            statementDateFormatter: StatementDateFormatter.shared)
        
        switch(result){
            case .success(let statementDetail):
                XCTAssertEqual(statementDetail, expectedResult)
            default:
                XCTFail()
        }
    }
    
    func testFetchFetchStatementDetailError(){
        // Given
        let myStatementDetailViewModel = MyStatementDetailViewModel(apiCaller: ApiCallerErrorMock(),
                                                                    statementId: "some id")

        // When
        let result = waitForFunctionCall(function: myStatementDetailViewModel.fetchStatementDetail,
                                         resultsObservable: myStatementDetailViewModel.itemDetailObservable)
        
        // Then
        switch(result){
            case .failure(let error):
                XCTAssertEqual(error, .loadDetailError)
            default:
                XCTFail()
        }
        
    }
    
}


private class ApiCallerSuccessMock : ApiCallerProtocol{
    
    enum ApiCallerError : Error{
        case myBalanceError
        case myStatementError
    }
    
    let detailResponse = MyStatetementDetailResponse(
        id: "some id",
        authentication: "authentication",
        tType: "Deposito",
        createdAt: ISO8601DateFormatter().string(from: Date()),
        amount: 100,
        to: "someone",
        description: "some description")
    
    func fetchMyBalance(completion: @escaping (Result<MyBalanceResponse, Error>) -> Void) {
        completion(.failure(ApiCallerError.myBalanceError))
    }
    
    func fetchMyStatement(numberOfItems: Int, offset: Int, completion: @escaping (Result<MyStatetementsResponse, Error>) -> Void) {
        completion(.failure(ApiCallerError.myStatementError))
    }
    
    func fetchMyStatementDetail(id: String, completion: @escaping (Result<MyStatetementDetailResponse, Error>) -> Void) {
        completion(.success(detailResponse))
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

