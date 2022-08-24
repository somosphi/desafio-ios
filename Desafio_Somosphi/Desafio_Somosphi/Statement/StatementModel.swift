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
    private(set) var statements: [Statement]

    var formattedAmount: String {
        if isAmountVisible {
            return Formatter.formatCurrency(value: amount)
        }
        return "––––––"
    }

    var canShowLoading: Bool {
        return hasMorePages
    }

    private(set) var isAmountVisible: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "visibleAmount")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "visibleAmount")
        }
    }

    // MARK: - Private properties

    private var amount: Int = 0
    private var page: Int = 0
    private var hasMorePages = true

    init() {
        statements = []
    }

    // MARK: - Internal Methods

    func fetchStatement() {
        guard hasMorePages else {
            return
        }

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
            page: page,
            onComplete: { [weak self] statements in
                guard let self = self else {
                    return
                }

                self.statements.append(contentsOf: statements.items)
                self.delegate?.didUpdateStatement()
                self.page += 1

                if statements.items.isEmpty {
                    self.hasMorePages = false
                }
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
