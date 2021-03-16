//
//  Preferences.swift
//  DesafioPhi
//
//  Created by Lucas Siqueira on 14/03/21.
//

import Foundation

/// Class com todas as configurações de preferências
class Preferences{
    //MARK: - Instance properties
    
    /// Sengleton das configurações de preferência
    static let shared = Preferences()
    /// Indica se o salvo deve ficar oculto
    var hideBalance = false
    
    //MARK: Init
    private init () {}
    

    //MARK: Function
    /**
     Método utilizado para inicializar o singleton
     */
    func requestForLocation () {
        print("Acesso liberado!")
    }
}
