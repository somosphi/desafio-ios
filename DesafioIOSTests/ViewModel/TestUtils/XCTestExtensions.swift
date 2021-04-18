//
//  FetchTestUtils.swift
//  DesafioIOSTests
//
//

import Foundation
import Combine
import XCTest


extension XCTestCase {
    
    func waitForFunctionCall<T : Any> (
        function : (() -> Void),
        resultsObservable : AnyPublisher<T, Never>) -> T{
        
        var itemsResult : T?
        let expectation =  self.expectation(description: "fetch returned results")
       
        let observer = resultsObservable.sink{ response in
            itemsResult = response
            expectation.fulfill()
        }
        function()
        waitForExpectations(timeout: 0.1)
        observer.cancel()
        return itemsResult!
    }
    
}
