//
//  URLRequest.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import Foundation

extension URLRequest {
    func containsToken() -> Bool {
        guard let headerFields = self.allHTTPHeaderFields else { return false }
        for (key, _) in headerFields {
            if key == StringConstants.authHeaderToken {
                return true
            }
        }
        return false
    }
}
