//
//  SharePresenterProtocol.swift
//  DesafioPhi
//
//  Created by Lucas Siqueira on 16/03/21.
//

import Foundation
import UIKit

/**
 Protocolo com a funçao essencial para compartilhar a tela
*/
protocol SharePresenterProtocol {
    
    // MARK: Present Share
    /**
     Método que exibe a aba de compartilhamento na view controller
     - Parameters:
        - viewController: View controller que exibirá a aba de compartilhamento
        - completion: Função que será executada após exibição da aba
    */
    func presentShare(on viewController: UIViewController, completion: @escaping () -> Void)
    
}
