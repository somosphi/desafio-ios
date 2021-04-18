//
//  ApiCaller.swift
//  DesafioIOS
//
//

import Foundation


class ApiCaller : ApiCallerProtocol{
    
    static let shared = ApiCaller()
    
    private init(){}
    
    private let acessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
    
    private enum endPoints{
        static let myBalance = "https://desafio-mobile-bff.herokuapp.com/myBalance"
        static let myStatement = "https://desafio-mobile-bff.herokuapp.com/myStatement"
        static let myStatementDetail = "https://desafio-mobile-bff.herokuapp.com/myStatement/detail"
    }
    
    func fetchMyBalance(completion : @escaping (Result<MyBalanceResponse,Error>) -> Void){
        
        guard let myBalanceURL = URL(string: endPoints.myBalance) else {
            completion(.failure(APIError.wrongURL))
            return
        };
    
        
        let request = createRequest(with: myBalanceURL, type: .GET)
        URLSession.shared.fetchJson(request: request, jsonType: MyBalanceResponse.self, apiError: APIError.failedToGetMyBalance, completionHandler: completion)
    }
    
    func fetchMyStatement(numberOfItems: Int, offset: Int, completion : @escaping (Result<MyStatetementsResponse,Error>) -> Void){
        
        guard let myStatementURL = URL(string: endPoints.myStatement + "/\(numberOfItems)/\(offset)") else { completion(.failure(APIError.wrongURL))
            return
        };
        
        let request = createRequest(with: myStatementURL, type: .GET)
        URLSession.shared.fetchJson(request: request, jsonType: MyStatetementsResponse.self, apiError: APIError.failedToGetMyStatement, completionHandler: completion)
    }
    
    func fetchMyStatementDetail(id: String, completion : @escaping (Result<MyStatetementDetailResponse,Error>) -> Void){
        
        guard let myStatementDetailURL = URL(string: endPoints.myStatementDetail + "/\(id)") else { completion(.failure(APIError.wrongURL))
            return
        };
        
        let request = createRequest(with: myStatementDetailURL, type: .GET)
        URLSession.shared.fetchJson(request: request, jsonType: MyStatetementDetailResponse.self, apiError: APIError.failedToGetMyStatementDetail, completionHandler: completion)
    }
    
    private func createRequest(with url: URL, type : HTTPMethod) -> URLRequest{
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = type.rawValue
        urlRequest.setValue(acessToken, forHTTPHeaderField: "token")
        return urlRequest
    }
    
}
