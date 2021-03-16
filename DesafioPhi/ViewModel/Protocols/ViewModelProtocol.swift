//
//  ViewModelProtocol.swift
//  DesafioPhi
//
//  Created by Lucas Siqueira on 15/03/21.
//

import Foundation

/**
 Protocolo que deve ser adotado por todas as View Models
 */
protocol ViewModelProtocol {
    
    /// Closure usada para atualizar os dados da view
    var reloadData : () -> () { get set }
    /// Closure usada para exibir mensagem de erro
    var errorMessage : (Error) -> () { get set }
    /// String com o resultado da requisição à API (para testes)
    var requestResult: String { get set }
    
    /// Método que realiza uma requisiçao API para buscar o saldo
    func getContentData()
}
