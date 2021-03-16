//
//  ReceiptViewModel.swift
//  DesafioPhi
//
//  Created by Lucas Siqueira on 14/03/21.
//

import Foundation
import UIKit

/**
 Classe View Model que configura os dados do comprovante para a view
 */
class ReceiptViewModel: ViewModelProtocol{
    //MARK: - Instance properties
    
    /// Model com o saldo atual
    private var receipt = ReceiptModel() {
        didSet{
            reloadData()
        }
    }
    
    //MARK: Init
    init (receipt: ReceiptModel){
        self.receipt = receipt
    }
    
    /// Variável que formata a string do saldo para a visualização
    var amount: String? {
        guard let amount = receipt.amount as NSNumber? else {return ""}
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        let amountFormatter = formatter.string(from: amount)
        return amountFormatter
    }
    
    /// Variável que formata a data da transação para a view
    var date: String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let dateFromString : Date = dateFormatter.date(from: receipt.createdAt ?? "") else {return ""}
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let newDate = dateFormatter.string(from: dateFromString)
        return newDate
    }
    
    /// Variável que busca na model e retorna tipo da transação
    var typeTransaction: String?{
        return receipt.description
    }
    
    /// Variável que busca na model e retorna o favorecido na transação
    var favored: String?{
        return receipt.to
    }
    
    /// Variável que retorna o nome da instituição bancária
    var bank: String?{
        return "Banco Phi"
    }
    
    /// Variável que busca na model e retorna o código de autenticação
    var authentication: String?{
        return receipt.authentication
    }
    
    /// Variável com o id da transação (utilizado para buscar o comprovante)
    var id: String?
    
    
    //MARK: Protocol Setup
    
    // Closure Reload
    var reloadData = {() -> () in }
    // Closure Error
    var errorMessage = {(error : Error) -> () in }
    // Result Request
    var requestResult = "Loading"
    
    func getContentData(){
        APIRequest.getContent(endpoint: "myStatement/detail/\(id ?? "")/") { [weak self] (result: Result<ReceiptModel, Error>) in
            switch result {
                case .success(let data):
                    self?.requestResult = "Sucess"
                    self?.receipt = data
                    
                case .failure(let error):
                    self?.requestResult = "Erro: \(error)"
                    self?.errorMessage(error)
            }
        }
    }
}
