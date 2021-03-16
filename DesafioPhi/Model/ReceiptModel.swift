//
//  ReceiptModel.swift
//  DesafioPhi
//
//  Created by Lucas Siqueira on 14/03/21.
//

import Foundation

/**
 Struct model do comprovante
 */
class ReceiptModel: Codable {
    /// Valor da transação
    var amount: Int?
    /// Identificador da transação
    var id: String?
    /// Código de autenticação
    var authentication: String?
    /// Tipo da transação
    var tType: String?
    /// Data da transação
    var createdAt: String?
    /// Quem enviou a transação
    var to: String?
    /// Descrição/tipo da transação
    var description: String?
    /// Nome da instituição bancária
    var bankName: String?
}
