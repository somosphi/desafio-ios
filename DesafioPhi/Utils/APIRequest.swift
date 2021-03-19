//
//  APIRequest.swift
//  DesafioPhi
//
//  Created by Lucas Siqueira on 12/03/21.
//

import Foundation

/**
 Classe com os métodos e informações para utilização da API
 */
class APIRequest {
    //MARK: - Instance properties
    
    /// Caminho base para acesso à API
    private static let basePath = "https://desafio-mobile-bff.herokuapp.com/"
    
    /// Chave de acesso à API
    private static let key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
    
    /// Variável estática que cria uma sessão personalizada
    private static let configurationSession: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 500
        return config
    }()
    
    /// Sessão que faz a requisição à API
    private static let session = URLSession.init(configuration: configurationSession)
    
    //MARK: Enum Error
    
    /**
     Enum com os casos de erro ao requisitar conteúdo da API
     */
    private enum RequestError: Error {
        /// Indica erro ao abrir sessão (falha de conexão/ internet)
        case networkError(Error)
        /// Indica que o HTTP não respondeu
        case notHTTPResponse
        /// Indica que a resposta da requisição é inválida
        case invalidHTTPResponse(Int)
        /// Indica erro ao converter arquivo JSON para o objeto Model
        case parseError(Error)
    }
    
    //MARK: Function
    
    /**
     Método que realiza a requisição do conteúdo à API com base no endpoint
     - Parameters:
        - endpoint: Endpoint da requisição (final da url)
        - result: Tipo de resultado da busca (Data ou Error)
     - Important: Este método recebe um modelo genérico do tipo *T* (Codable) para realizar a conversão de JSON para data. Siga o código de exemplo para utilizar a função.
     ```
     APIRequest.getContent(endpoint: "urlEndpoint") { [weak self] (result: Result<GenericCodableModel, Error>) in
        ...
     }
     ```
     - Throws: Retorna a causa da falha da requisição. Os erros retornados são do tipo *RequestError*
     */
    class func getContent<T: Codable> (endpoint: String, completionHandler: @escaping (_ result: Result<T, Error>) -> Void){
        
        guard let url = URL(string: "\(basePath)\(endpoint)") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(key, forHTTPHeaderField: "token")
        
        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                completionHandler(.failure(RequestError.networkError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                completionHandler(.failure(RequestError.notHTTPResponse))
                return
            }

            guard 200 ..< 300 ~= httpResponse.statusCode else {
                completionHandler(.failure(RequestError.invalidHTTPResponse(httpResponse.statusCode)))
                return
            }

            do {
                let content = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(content))
            } catch let parseError {
                completionHandler(.failure(RequestError.parseError(parseError)))
            }
        }
        dataTask.resume()
    }
    
}
