//
//  ExtractModel.swift
//  Desafio_Somosphi
//
//  Created by Suh on 10/08/22.
//

import UIKit

protocol ExtractModelDelegate: AnyObject {
    func didUpExtracts()
    func didUpdateBalance()
}

class ExtractModel {

    private(set) var extract: [Extract]
    weak var delegate: ExtractModelDelegate?
    var service: ExtractService? = ExtractService()
    var amount: Int = 0

    init() {
        extract = []
    }

    func fetchExtract() {
        extract = mockExtract()
        // delegate?.didUpExtracts()
        service?.fecthAmont(
            onComplete: { result in
                self.amount = result.amount
                self.delegate?.didUpdateBalance()
            },
            onError: { error in
                print(error.localizedDescription)
            }
        )

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
