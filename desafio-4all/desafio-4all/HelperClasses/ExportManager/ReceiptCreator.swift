//
//  ReceiptCreator.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 03/01/21.
//

import UIKit
import PDFKit

class ReceiptCreator: PDFCreator {
    
    let pageRect = CGRect(x: 0, y: 0, width: 375, height: 562)
    
    func createPDF(exportValue: Exportable) -> Result<Data, CustomError> {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsPDFRenderer(bounds: pageRect)
            
            guard let statementDetail = exportValue as? StatementDetail else {
                return .failure(CustomError.failedCastObject)
            }
            
            let data = renderer.pdfData { (context) in
                context.beginPage()
                createReceiptFields(statementDetail: statementDetail)
            }
            
            return .success(data)
        } else {
            return .failure(CustomError.incorrectOSVersion)
        }
    }
    
    func createReceiptFields(statementDetail: StatementDetail) {
        
        // MARK: Receipt Header
        
        let mediumSemiBold = [ NSAttributedString.Key.font: MediumSemiboldLabel().font! ]
        let baseFont = [ NSAttributedString.Key.font: BaseLabel().font! ]
        
        let receiptTitle = NSAttributedString(string: StringConstants.receiptTitle, attributes: mediumSemiBold)
        receiptTitle.draw(at: CGPoint(x: pageRect.midX - receiptTitle.size().width/2, y: 20))
        
        drawLine(rect: CGRect(x: pageRect.minX + 15, y: 60, width: pageRect.width - 30, height: 1))
        
        // MARK: Movement Type
        
        let movementType = NSAttributedString(string: StringConstants.movementTypeTitle, attributes: mediumSemiBold)
        movementType.draw(at: CGPoint(x: pageRect.minX + 15, y: 80))
        
        let movementValue = NSAttributedString(string: statementDetail.description ?? "", attributes: baseFont)
        movementValue.draw(at: CGPoint(x: pageRect.minX + 15, y: 110))
        
        // MARK: Value
        
        let valueTitle = NSAttributedString(string: StringConstants.valueTitle, attributes: mediumSemiBold)
        valueTitle.draw(at: CGPoint(x: pageRect.minX + 15, y: 160))
        
        let valueText = NSAttributedString(string: statementDetail.getCorrectlyAmount().getReaisValue(), attributes: baseFont)
        valueText.draw(at: CGPoint(x: pageRect.minX + 15, y: 190))
        
        // MARK: From
        
        let fromTitle = NSAttributedString(string: StringConstants.fromTitle, attributes: mediumSemiBold)
        fromTitle.draw(at: CGPoint(x: pageRect.minX + 15, y: 240))
        
        let fromValue = NSAttributedString(string: statementDetail.getCorrectlyFromString(), attributes: baseFont)
        fromValue.draw(at: CGPoint(x: pageRect.minX + 15, y: 270))
        
        // MARK: Bank Name
        
        let bankNameTitle = NSAttributedString(string: StringConstants.bankNameTitle, attributes: mediumSemiBold)
        bankNameTitle.draw(at: CGPoint(x: pageRect.minX + 15, y: 320))
        
        let bankName = NSAttributedString(string: statementDetail.bankName ?? StringConstants.emptyBankName, attributes: baseFont)
        bankName.draw(at: CGPoint(x: pageRect.minX + 15, y: 350))
        
        // MARK: Date
        
        let dateTitle = NSAttributedString(string: StringConstants.dateTitle, attributes: mediumSemiBold)
        dateTitle.draw(at: CGPoint(x: pageRect.minX + 15, y: 390))
        
        let dateValue = NSAttributedString(string: statementDetail.createdAt!.getCompleteFormat(), attributes: baseFont)
        dateValue.draw(at: CGPoint(x: pageRect.minX + 15, y: 420))
        
        // MARK: Autenticate
        
        let autenticateTitle = NSAttributedString(string: StringConstants.autenticationTitle, attributes: mediumSemiBold)
        autenticateTitle.draw(at: CGPoint(x: pageRect.minX + 15, y: 470))
        
        let autenticateValue = NSAttributedString(string: statementDetail.authentication ?? "", attributes: baseFont)
        
        let textRect =  CGRect(x: pageRect.minX + 15, y: 500, width: pageRect.width - 30, height: 100)
        autenticateValue.draw(with: textRect, options: .usesLineFragmentOrigin, context: .none)
    }
    
    func drawLine(rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 0)
        UIColor.appGray.setFill()
        path.fill()
    }
    
    
}
