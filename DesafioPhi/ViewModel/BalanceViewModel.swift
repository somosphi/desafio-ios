//
//  BalanceViewModel.swift
//  DesafioPhi
//
//  Created by Lucas Siqueira on 11/03/21.
//

import Foundation
import UIKit

/**
 Classe View Model do saldo que configura o saldo para a view
 */
class BalanceViewModel: ViewModelProtocol{
    //MARK: - Instance properties
    
    /// Model com o saldo atual
    private var balance = BalanceModel() {
        didSet {
            reloadData()
        }
    }
    
    //MARK: Init
    init (balance: BalanceModel){
        self.balance = balance
    }
    
    /// Variável que formata a string do saldo para a visualização
    var amount: String? {
        if Preferences.shared.hideBalance == false && balance.amount != nil{
            guard let amount = balance.amount else {return nil}
            let amountNumber = amount as NSNumber
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            let amountFormatter = formatter.string(from: amountNumber)
            return amountFormatter
        }else{
            return "─────"
        }
    }
    
    /// Variável que retorna a imagem do olho com base nas preferencias de oclusão do saldo
    var eyeImage: UIImage?{
        if Preferences.shared.hideBalance == false{
            return UIImage(systemName: "eye.fill")
        }else{
            return UIImage(systemName: "eye.slash.fill")
        }
    }
    
    //MARK: Functions
    
    /**
     Método que atualiza as preferencia de ocultar o saldo
     */
    func hiddenAmount(){
        Preferences.shared.hideBalance = !Preferences.shared.hideBalance
        DataPersistence.shared.saveLocalData(data: Preferences.shared.hideBalance, key: "Hidden")
        reloadData()
    }
    
    //MARK: Protocol Setup
    
    // Closure Reload
    var reloadData = {() -> () in }
    // Closure Error
    var errorMessage = {(error : Error) -> () in }
    // Result Request
    var requestResult = "Loading"
    
    func getContentData(){
        APIRequest.getContent(endpoint: "myBalance/") { [weak self] (result: Result<BalanceModel, Error>) in
            switch result {
                case .success(let data):
                    self?.requestResult = "Sucess"
                    self?.balance = data
                    
                case .failure(let error):
                    self?.requestResult = "Erro: \(error)"
                    self?.errorMessage(error)
            }
        }
    }
}
