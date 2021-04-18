//
//  HttpExtensions.swift
//  DesafioIOS
//
//

import Foundation

enum HTTPMethod : String{
    case GET
    case POST
}

extension URLSession{
    
    func fetchJson<T>(request : URLRequest, jsonType : T.Type, apiError: Error, completionHandler : @escaping (Result<T,Error>) -> Void) where T : Decodable{
        let requestTask = self.dataTask(with: request){ data, response, error in
            guard let data = data , error == nil else{
                completionHandler(.failure(apiError))
                return
            }
            do{
                let jsonObject = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(jsonObject))
            }catch{
                completionHandler(.failure(error))
            }
        }
        requestTask.resume()
    }
    
    func testJson(request : URLRequest, apiError: Error){
        let requestTask = self.dataTask(with: request){ data, response, error in
            guard let data = data , error == nil else{
                print(error?.localizedDescription ?? "")
                
                return
            }
            do{
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(jsonObject)
            }catch{
                print(error.localizedDescription)
                
            }
        }
        requestTask.resume()
    }
}
