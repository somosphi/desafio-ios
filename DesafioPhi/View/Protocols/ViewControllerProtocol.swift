//
//  ViewControllerProtocol.swift
//  DesafioPhi
//
//  Created by Lucas Siqueira on 15/03/21.
//

import Foundation

/**
 Protocolo que deve ser adotado por todas as View Controllers
 */
protocol ViewControllerProtocol {
    /// Método que chama todas as funções de configuração da view
    func setup()
    /// Método que configura as closures das ViewModels
    func closureSetup()
    /// Método que confugura a busca das informações pelas View Models
    func getContentSetup()
    /// Método que configura a aparência da Navigation Controller
    func navigationControllerSetup()
}
