//
//  StatementLoadErrorModel.swift
//  DesafioIOS
//
//

import Foundation

enum StatementLoadErrorViewModel : Error{
    case loadStatementsError
    case loadBalanceError
    case loadDetailError
    
    var shortDescription : String {
        switch self {
            case .loadStatementsError:
                return "Erro ao buscar extrato"
            case .loadBalanceError:
                return "Erro ao buscar saldo"
            case .loadDetailError:
                return "Erro ao buscar detalhes do extrato"
        }
    }
}
