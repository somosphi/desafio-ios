//
//  DataPersistence.swift
//  DesafioPhi
//
//  Created by Lucas Siqueira on 14/03/21.
//

import Foundation

/// Classe que configura a persistência de dados
class DataPersistence {
    
    //MARK: - Instance properties
    /// Sengleton da persistência de dados
    static let shared = DataPersistence ()

    //MARK: - Init
    
    // Inicializando os dados do User Defaults
    private init () {
        if !UserDefaults.standard.bool(forKey: "Initial"){
            saveLocalData(data: true, key: "Initial")
            saveLocalData(data: false, key: "Hidden")
            Preferences.shared.hideBalance = false
        }else{
            Preferences.shared.hideBalance = UserDefaults.standard.bool(forKey: "Hidden")
        }
    }
    
    //MARK: Functions
    
    /**
     Método utilizado para inicializar o singleton
     */
    func requestForLocation () {
       print("Acesso liberado!")
    }
    
    /**
     Method que salva algum valor no device
     - parameter data: valor a ser salva
     - parameter key: chave do valor
    */
    func saveLocalData(data: Any?, key: String){
        UserDefaults.standard.set(data, forKey: key)
    }
    
}
