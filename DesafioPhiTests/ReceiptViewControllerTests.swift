//
//  ReceiptViewControllerTests.swift
//  DesafioPhiTests
//
//  Created by Lucas Siqueira on 16/03/21.
//

import XCTest
@testable import DesafioPhi

/**
 Classe de testes da ReceiptViewController
*/
class ReceiptViewControllerTests: XCTestCase {
    // MARK: Test Loading
    
    /**
     Método de teste que verifica se a view controller inicializou o atributo *sharePresenter*
    */
    func testLoading() {
        // Arrange
        guard let sut = getViewController() else { return }
            
        // Act
        _ = sut.view
            
        // Assert
        XCTAssertNotNil(sut.sharePresenter, "O objeto 'sharePresenter' não foi inicializado.")
    }
    
    // MARK: Test Share Presenter
    
    /**
     Método de teste que verifica se a aba de compartilhamento foi exibida na view controller correta
    */
    func testSharePresenter() {
        // Arrange
        guard let sut = getViewController() else { return }
        let sharePresenter = SharePresenterMock()
        sut.sharePresenter = sharePresenter

        // Act
        sut.share()

        // Assert
        XCTAssert(sharePresenter.presentCalled, "O método presentShare() não foi chamado.")
        XCTAssert(sharePresenter.viewController == sut, "View controller errada.")

    }
    
    // MARK: Test Hide Share Button
    
    /**
     Método de teste que verifica se o botão de compartilhar ficou oculto durante o compartilhamento
    */
    func testHideShareButton() {
        // Arrange
        guard let sut = getViewController() else { return }
        _ = sut.view
        sut.prepareShare(sut)

        // Act
        let value = sut.shareButton.isHidden

        // Assert
        XCTAssertTrue(value, "O botão de compartilhar não está oculto")

    }
    
    // MARK: Get ViewController
    
    /**
     Método que cria a viewController para ser testada
     - note: A view controller só será criada caso exista uma no storyboard com o identificador correto
     - returns: View controller criada ou nil
    */
    func getViewController() -> ReceiptViewController? {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ExtractVC") as? ReceiptViewController else {
            XCTAssert(false, "A view controller 'ExtractVC' não foi identificada")
            return nil
        }
        return vc
    }

}
