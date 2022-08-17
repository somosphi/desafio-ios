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
    var service: AmountService? = AmountService()
    private var amount: Int = 0
    var formattedAmount: String {
        return getFormattedValue(of: amount)
    }

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

    private func getFormattedValue(of value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "R$"
        formatter.alwaysShowsDecimalSeparator = true
        formatter.locale = Locale(identifier: "pt_BR")
        let number = formatter.string(from: NSNumber(value: value))
        return number ?? "R$ 0,00"
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
