//
//  APILogger.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 09/11/20.
//

import Foundation

final class APILogger {
    func logRequest(_ request: URLRequest) {
        #if DEBUG
        print("\n========== REQUEST BEGIN ==========")
        print("URL: \(request.url?.absoluteString ?? "-")")
        print("Method: \(request.httpMethod ?? "-")")
        if let body = request.httpBody {
            print("Body:\n\(String(data: body, encoding: .utf8) ?? "body data to string conversion failed")")
        }
        print("========== REQUEST END ==========\n")
        #endif
    }
    
    func logResponse(_ response: (Data?, URLResponse?, Error?)) {
        #if DEBUG
        
        guard let httpResponse = response.1 as? HTTPURLResponse else {
            print("\nNO RESPONSE!!!!")
            return
        }
        
        print("\n========== RESPONSE BEGIN ==========")
        print("CODE: \(httpResponse.statusCode)")
        print("URL: \(response.1?.url?.absoluteString ?? "-")")
        print("Error:\n\(response.2?.localizedDescription ?? "-")")
        
        var debugData: String?
        if let data = response.0 {
            debugData = String(data: data, encoding: .utf8)
        }
        print("Body:\n" + (debugData ?? "-"))
        print("========== RESPONSE END ==========\n")
        #endif
    }
    
    func logError(_ error: Error) {
        
       print ("🆘🆘 Error did happen \(error)🆘🆘 ")
    
        
    }
}

