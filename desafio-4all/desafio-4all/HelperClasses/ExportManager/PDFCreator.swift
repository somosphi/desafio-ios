//
//  PDFCreator.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 03/01/21.
//

import UIKit

protocol PDFCreator {
    var pageRect: CGRect { get }
    func createPDF(exportValue: Exportable) -> Result<Data, CustomError>
}
