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
    func didErrorRepositories()
}

class StatementModel {

    // MARK: - Internal Properties

    weak var delegate: StatementModelDelegate?
    var service: AmountService?
    var serviceStatement: StatementService?

    var formattedAmount: String {
        if isAmountVisible {
            return Formatter.formatCurrency(value: amount)
        }
        return "––––––"
    }

    // MARK: - Private properties

    private(set) var statements: [Statement]
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
        statements = []
    }

    // MARK: - Internal Methods

    func fetchStatement() {
        service?.fecthAmount(
            onComplete: { result in
                self.amount = result.amount
                self.delegate?.didUpdateBalance()
            },
            onError: { error in
                print(error.localizedDescription)
            }
        )

        serviceStatement?.fetchStatements(
            onComplete: { [weak self] statements in
                self?.statements.append(contentsOf: statements.items)
                self?.delegate?.didUpdateStatement()
            },
            onError: { error in
                self.delegate?.didErrorRepositories()
                print(error.localizedDescription)
            })
    }

    func changeAmountVisibility() {
        isAmountVisible = !isAmountVisible
        delegate?.didUpdateBalance()
    }

}

#if DEBUG
private func mockStatement() -> [Statement] {
    return [
        .fixture(),
        .fixture(),
        .fixture()
    ]
}
#endif
