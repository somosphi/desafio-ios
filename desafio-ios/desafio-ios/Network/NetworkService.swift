//
//  NetworkService.swift
//  desafio-ios
//
//  Created by Alexandre Scheer Bing on 07/12/20.
//

import Foundation
import RxSwift

class NetworkService {
    
    let baseURL = "https://desafio-ios-phi-bff.herokuapp.com"
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
    
    func fetchCurrentAmmount() -> Observable<Amount> {
        return Observable.create { [self] observer -> Disposable in
            var request = URLRequest(url: URL(string: baseURL+"/myBalance")!)
            request.setValue(token, forHTTPHeaderField: "token")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if response != nil {
                    guard let data = data else { return }
                    do {
                        let amount = try JSONDecoder().decode(Amount.self, from: data)
                        observer.onNext(amount)
                    }
                    catch {
                        observer.onError(error)
                    }
                    
                } else {
                    return
                }
            }
            
            task.resume()
            return Disposables.create{
                task.cancel()
            }
        }
    }
    
    func fetchMyStatement(offset: Int) -> Observable<StatementList>{
        return Observable.create { [self] observer -> Disposable in
            var request = URLRequest(url: URL(string: baseURL+"/myStatement/100/\(offset)")!)
            request.setValue(token, forHTTPHeaderField: "token")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if response != nil {
                    guard let data = data else { return }
                    do {
                        print(data)
                        let statement = try JSONDecoder().decode(StatementList.self, from: data)
                        observer.onNext(statement)
                    }
                    catch {
                        observer.onError(error)
                    }
                    
                } else {
                    return
                }
            }
            
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    func fetchTransferDetails(id: String) -> Observable<Statement>{
        return Observable.create { [self] observer -> Disposable in
            var request = URLRequest(url: URL(string: baseURL+"/myStatement/detail/"+id)!)
            request.setValue(token, forHTTPHeaderField: "token")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if response != nil {
                    guard let data = data else { return }
                    do {
                        print(data)
                        let statement = try JSONDecoder().decode(Statement.self, from: data)
                        observer.onNext(statement)
                    }
                    catch {
                        observer.onError(error)
                    }
                    
                } else {
                    return
                }
            }
            
            task.resume()
            
            return Disposables.create{
                task.cancel()
            }
        }
    }
}
