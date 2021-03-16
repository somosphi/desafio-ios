//
//  SharePresenterMock.swift
//  DesafioPhiTests
//
//  Created by Lucas Siqueira on 16/03/21.
//

import Foundation
import UIKit
@testable import DesafioPhi

/**
 Mock que simula a classe *SharePresenter*
*/
class SharePresenterMock: SharePresenterProtocol {
    
    /// indica se a função que apresenta a aba de compartilhar foi chamada
    var presentCalled = false
    /// view controller que exibirá a aba de compartilhamento
    var viewController: UIViewController?
    
    //MARK: Present Share
    func presentShare(on viewController: UIViewController, completion: @escaping () -> Void) {
        presentCalled = true
        self.viewController = viewController
    }
    
}
