//
//  ExtractModel.swift
//  DesafioPhi
//
//  Created by Lucas Siqueira on 13/03/21.
//

import Foundation

/**
 Classe model do extrato das transações
 */
class ExtractModel: Codable{
    var items: [Item] = []

}

// MARK: - Item
/**
 Struct model com as infomações da transação
 */
class Item: Codable {
    /// Data da transação
    var createdAt: String?
    /// Identificador da transação
    var id: String?
    /// Valor da transação
    var amount: Int?
    /// Quem enviou a transação
    var to: String?
    /// Quem receboeu a transação
    var from: String?
    /// Descrição/tipo da transação
    var description: String?
    /// Tipo da transação
    var tType: String?
    /// Nome da instituição bancária
    var bankName: String?
}
