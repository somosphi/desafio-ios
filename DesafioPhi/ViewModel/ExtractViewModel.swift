//
//  ExtractViewModel.swift
//  DesafioPhi
//
//  Created by Lucas Siqueira on 13/03/21.
//

import Foundation
import UIKit

/**
 Classe View Model que configura os dados das transações para a view
 */
class ExtractViewModel: ViewModelProtocol {
    //MARK: - Instance properties
    
    /// Model com o saldo atual
    private var extracts : [Item] = [] {
        didSet{
            reloadData()
        }
    }
    
    //MARK: Init
    init (extracts: [Item]){
        self.extracts = extracts
    }
    
    /// Indica a quantidade de itens
    var countItems : Int {
        return extracts.count
    }
    
    /// Número de itens que cada request deve adquirir
    private let itemsPerRequest = 10
    
    //MARK: Functions
    
    /**
     Método que busca na model e retorna o id da transação
     - Parameter index: posição do item no array
     - Returns: String com o id da transação
     */
    func returnIdTransaction(index: Int) -> String?{
        return extracts[index].id
    }
    
    /**
     Método que busca na model e formata o tipo da transação
     - Parameter index: posição do item no array
     - Returns: String com o tipo da transação
     */
    func returnTypeTransaction(index: Int) -> String?{
        return extracts[index].description
    }
    
    /**
     Método que busca na model a string do favorecido
     - Parameter index: posição do item no array
     - Returns: String com o favorecido
     */
    func returnFavored(index: Int) -> String?{
        if extracts[index].tType == "BANKSLIPCASHIN"{
            return "Sua Conta"
        }else if extracts[index].to != nil{
            return extracts[index].to
        }else{
            return extracts[index].from
        }
    }
    
    /**
     Método que busca na model e formata o valor da transação
     - Parameter index: posição do item no array
     - Returns: String com o valor da transação
     */
    func returnAmount (index: Int) -> String? {
        guard let amount = extracts[index].amount else {return nil}
        let amountNumber = amount as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        let amountFormatter = formatter.string(from: amountNumber)
        return amountFormatter
    }
    
    /**
     Método que verifica na model se a transação é do tipo PIX
     - Parameter index: posição do item no array
     - Returns: Booleano que indica se a transação é do tipo PIX
     */
    func returnPix (index: Int) -> Bool{
        if extracts[index].tType == "PIXCASHIN" || extracts[index].tType == "PIXCASHOUT"{
            return true
        }else{
            return false
        }
    }
    
    /**
     Método que busca na model a data da transação e formata para "dd/MM"
     - Parameter index: posição do item no array
     - Returns: String da data formatada para "dd/MM"
     */
    func returnDate (index: Int) -> String?{
        guard let date = extracts[index].createdAt else {return nil}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let dateFromString : Date = dateFormatter.date(from: date) else {return ""}
        dateFormatter.dateFormat = "dd/MM"
        let newDate = dateFormatter.string(from: dateFromString)
        return newDate
    }
    
    //MARK: Protocol Setup
    
    // Closure Reload
    var reloadData = {() -> () in }
    // Closure Error
    var errorMessage = {(error : Error) -> () in }
    // Result Request
    var requestResult = "Loading"
    
    func getContentData(){
        APIRequest.getContent(endpoint: "myStatement/\(itemsPerRequest)/\(countItems/itemsPerRequest)/") { [weak self] (result: Result<ExtractModel, Error>) in
            switch result {
                case .success(let data):
                    self?.requestResult = "Sucess"
                    self?.extracts.append(contentsOf: data.items)
                    
                case .failure(let error):
                    self?.requestResult = "Erro: \(error)"
                    self?.errorMessage(error)
            }
        }
    }
    
}
