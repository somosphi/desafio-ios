//
//  ExtractViewModelTests.swift
//  DesafioPhiTests
//
//  Created by Lucas Siqueira on 16/03/21.
//

import XCTest
@testable import DesafioPhi

/**
 Classe de conversao de valores da model pela *ExtractViewModel*
*/
class ExtractViewModelTests: XCTestCase {
    //MARK: - Instance properties
    
    /// Array da model para teste
    var model = [Item]()
    /// Item com as instancias da model
    let item = Item()
    /// View model que será testada
    var sut : ExtractViewModel?
    
    //MARK: Setup
    
    override func setUp() {
        model.append(item)
        sut = ExtractViewModel(extracts: model)
    }
    
    // MARK: Test Convert Amount
    
    /**
     Método que testa a conversão do valor para o formato da moeda
    */
    func testConvertAmount(){
        // Arrange
        item.amount = 100
        
        // Act
        guard let value = sut?.returnAmount(index: model.count-1) else {return}
            
        // Assert
        XCTAssertEqual(value, "$100.00", "O valor não foi convertido corretamente")
    }
    
    // MARK: Test Verify PIX
    
    /**
     Método que testa se o retorno da transação foi do tipo PIX
    */
    func testVerifyPIX(){
        // Arrange
        item.tType = "PIXCASHIN"
        
        // Act
        guard let isPix = sut?.returnPix(index: model.count-1) else {return}
            
        // Assert
        XCTAssertTrue(isPix, "A transação não é do tipo PIX")
    }
    
    // MARK: Test Convert Date
    
    /**
     Método que testa a data foi convertida para o formato *dd/MM*
    */
    func testConvertDate(){
        // Arrange
        item.createdAt = "2020-11-19T03:00:00Z"
        
        // Act
        guard let date = sut?.returnDate(index: model.count-1) else {return}
            
        // Assert
        XCTAssertEqual(date, "19/11", "A data não foi convertida corretamente")
    }

}
