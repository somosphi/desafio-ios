//
//  URL.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 03/01/21.
//

import UIKit

extension URL {
    
    func convertPDF() -> Result<UIImage, CustomError> {
        
        guard let document = CGPDFDocument(self as CFURL) else {
            return .failure(CustomError.castToDocumentError)
        }
        guard let page = document.page(at: 1) else {
            return .failure(CustomError.getPageError)
        }
        
        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)
            
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            
            ctx.cgContext.drawPDFPage(page)
        }
        
        return .success(img)
    }
}
