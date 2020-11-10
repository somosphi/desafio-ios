//
//  ServiceLayer.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 09/11/20.
//

import Foundation

final class ServiceLayer {
    
    let api = APIRequest()
    
    //MARK: - MyBalance API Request
    func requestMyBalance() {
        
        //let endpoint = "https://desafio-ios-phi.herokuapp.com/myBalance"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "demo3162614.mockable.io"
        urlComponents.path = "/myBalance"
        
        guard let urlString = urlComponents.url?.absoluteString else { return }
        
        api.request(urlString: urlString,
                    method: .get,
                    parameters: nil) { (response: MyBalance) in
            print(response.amount)
            
        } failure: { (error) in
            return
        }
    }
    
    
    //MARK: - MyStatement API Request
    func requestMyStatement() {
        
        //let endpoint = "https://desafio-ios-phi.herokuapp.com/myStatement/:limit/:offset"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "demo3162614.mockable.io"
        urlComponents.path = "/myStatement/:limit/:offset"
   
        guard let urlString = urlComponents.url?.absoluteString else { return }
        
        api.request(urlString: urlString,
                    method: .get,
                    parameters: nil) { (response: MyStatement) in
            print(response.items)
            
        } failure: { (error) in
            return
        }
    }
}
