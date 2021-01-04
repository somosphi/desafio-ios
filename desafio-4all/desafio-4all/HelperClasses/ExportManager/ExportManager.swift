//
//  ExportManager.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 03/01/21.
//

import UIKit

protocol Exportable {}

class ExportManager {
    
    let pdfCreator: PDFCreator
    
    // MARK: - Initialize
    
    init(pdfCreator: PDFCreator) {
        self.pdfCreator = pdfCreator
    }
    
    // MARK: - Functions
    
    func getImage(exportValue: Exportable) -> Result<UIImage, CustomError>{
        do {
            let resultData =  pdfCreator.createPDF(exportValue: exportValue)
            let resultURL = try resultData.get().getURL()
            let resultImage = try resultURL.get().convertPDF()
            let image = try  resultImage.get()
            image.accessibilityIdentifier = "ExportImage"
            return .success(image)
        } catch {
            if let customError = error as? CustomError {
                return .failure(customError)
            }
            return .failure(CustomError.unknowError)
        }
    }
    
    func getPdfURL(exportValue: Exportable) -> Result<URL, CustomError> {
        do {
            let resultData =  pdfCreator.createPDF(exportValue: exportValue)
            let resultURL = try resultData.get().getURL()
            let url = try resultURL.get()
            return .success(url)
        } catch {
            if let customError = error as? CustomError {
                return .failure(customError)
            }
            return .failure(CustomError.unknowError)
        }
    }
}


