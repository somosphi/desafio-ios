//
//  StatementModel.swift
//  Desafio_Somosphi
//
//  Created by Suh on 10/08/22.
//

import UIKit

protocol StatementModelDelegate: AnyObject {
    func didUpdateStatement()
    func didUpdateBalance()
}

class StatementModel {

    // MARK: - Internal Properties

    weak var delegate: StatementModelDelegate?
    var service: AmountService?

    var formattedAmount: String {
        if isAmountVisible {
            return getFormattedValue(of: amount)
        }
        return "––––––"
    }

    // MARK: - Private properties

    private(set) var statement: [Statement]
    private var amount: Int = 0

    private(set) var isAmountVisible: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "visibleAmount")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "visibleAmount")
        }
    }

    init() {
        statement = []
    }

    // MARK: - Internal Methods

    func fetchStatement() {
        statement = mockStatement()
        // delegate?.didUpStatement()
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

    func changeAmountVisibility() {
        isAmountVisible = !isAmountVisible
        delegate?.didUpdateBalance()
    }

    // MARK: - Private methods

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

private func mockStatement() -> [Statement] {
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
