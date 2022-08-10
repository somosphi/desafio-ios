//
//  ExtractModel.swift
//  Desafio_Somosphi
//
//  Created by Suh on 10/08/22.
//

import UIKit

protocol ExtractModelDelegate: AnyObject {
    func didUpExtracts()
}

class ExtractModel {

    private(set) var extract: [Extract]
    weak var delegate: ExtractModelDelegate?

    init() {
        extract = []
    }

    func fetchExtract() {
        extract = mockExtract()
        delegate?.didUpExtracts()
    }

}

private func mockExtract() -> [Extract] {
    return [
        .fixture(),
        .fixture(),
        .fixture(),
        .fixture(),
        .fixture(),
        .fixture(),
        .fixture(),
        .fixture(),
        .fixture()
    ]
}
