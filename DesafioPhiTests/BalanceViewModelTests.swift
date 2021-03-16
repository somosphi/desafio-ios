//
//  BalanceViewModelTests.swift
//  BalanceViewModelTests
//
//  Created by Lucas Siqueira on 16/03/21.
//

import XCTest
@testable import DesafioPhi

/**
 Classe de conversao de valores da model pela *BalanceViewModel*
*/
class BalanceViewModelTests: XCTestCase {
    //MARK: - Instance properties
    
    /// Model com as propriedades para teste
    let model = BalanceModel()
    /// View model que será testada
    var sut : BalanceViewModel?
    
    //MARK: Setup
    
    override func setUp() {
        sut = BalanceViewModel(balance: model)
    }
    
    
    // MARK: Test Convert Balance
    
    /**
     Método que testa a conversão do saldo para o formato da moeda
    */
    func testConvertBalance(){
        // Arrange
        model.amount = 100
        Preferences.shared.hideBalance = false
        
        // Act
        guard let value = sut?.amount else {return}
            
        // Assert
        XCTAssertEqual(value, "$100.00", "O valor não foi convertido corretamente")
    }
    
    // MARK: Test Hide Balance
    
    /**
     Método que testa se o saldo fica oculto quando o valor armazenado na persistencia de dados é igual a *true*
    */
    func testHideBalance(){
        // Arrange
        model.amount = 100
        Preferences.shared.requestForLocation()
        Preferences.shared.hideBalance = true
        
        // Act
        guard let value = sut?.amount else {return}
            
        // Assert
        XCTAssertEqual(value, "─────", "O valor não foi convertido corretamente")
    }
    
    // MARK: Test Modify EyeImage
    
    /**
     Método que testa se a variável retorna a imagem do olho com base nos dados salvos
    */
    func testModifyEyeImage(){
        // Arrange
        let valuePersistence = Preferences.shared.hideBalance
        let nameImage = valuePersistence ? "eye.slash.fill" : "eye.fill"
        let resultImage = UIImage(systemName: nameImage)
        
        // Act
        guard let image = sut?.eyeImage else {return}
            
        // Assert
        XCTAssertEqual(image, resultImage, "A imagem é diferente do esperado")
    }

}
