//
//  Endpoints.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 25/02/21.
//

import Foundation

extension URL {
    
    static var myBalance: URL {
        makeEndpoint("myBalance")
    }
    
    static func myStatement(withId id: String) -> URL {
        makeEndpoint("myStatement/detail/\(id)")
    }
    
    static func myStatementList(withOffset offset: Int) -> URL {
        makeEndpoint("/myStatement/10/\(offset)")
    }
}

private extension URL {
    static func makeEndpoint(_ endpoint: String) -> URL {
        URL(string: "https://desafio-mobile-bff.herokuapp.com/\(endpoint)")!
    }
}
