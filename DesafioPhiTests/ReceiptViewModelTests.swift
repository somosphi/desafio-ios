//
//  ReceiptViewModelTests.swift
//  DesafioPhiTests
//
//  Created by Lucas Siqueira on 16/03/21.
//

import XCTest
@testable import DesafioPhi

/**
 Classe de conversao de valores da model pela *ReceiptViewModel*
*/
class ReceiptViewModelTests: XCTestCase {
    //MARK: - Instance properties
    
    /// Model com as propriedades para teste
    let model = ReceiptModel()
    /// View model que será testada
    var sut : ReceiptViewModel?
    
    //MARK: Setup
    
    override func setUp() {
        sut = ReceiptViewModel(receipt: model)
    }
    
    // MARK: Test Convert Amount
    
    /**
     Método que testa a conversão do valor para o formato da moeda
    */
    func testConvertAmount(){
        // Arrange
        model.amount = 100
        
        // Act
        guard let value = sut?.amount else {return}
            
        // Assert
        XCTAssertEqual(value, "$100.00", "O valor não foi convertido corretamente")
    }
    
    // MARK: Test Convert Date
    
    /**
     Método que testa a data foi convertida para o formato *dd/MM/yyyy*
    */
    func testConvertDate(){
        // Arrange
        model.createdAt = "2020-11-19T03:00:00Z"
        
        // Act
        guard let date = sut?.date else {return}
            
        // Assert
        XCTAssertEqual(date, "19/11/2020", "A data não foi convertida corretamente")
    }

}
