//
//  StatementsViewModel.swift
//  Desafio-iOS
//
//  Created by Alex Freitas on 23/05/21.
//

import Foundation
import UIKit

class ViewControllerViewModel: NSObject {
    private var service: QueryService = QueryService()

    private var amount: Double? {
        didSet {
            self.bindViewModelToController()
        }
    }

    private(set) var hideAmount: Bool = UserDefaults.standard.bool(forKey: "HideAmount") {
        didSet {
            self.bindViewModelToController()
        }
    }

    private(set) var isLoadingAmount: Bool = false {
        didSet {
            self.bindViewModelToController()
        }
    }

    var amountText: String? {
        if !hideAmount, let amount = amount {
            return String(format: "%.2f", amount)
        }

        return nil
    }

    var hideAmountBar: Bool {
        return !hideAmount
    }

    var bindViewModelToController: (() -> Void) = {}

    override init() {
        super.init()
        getData()
    }

    func getData() {
        self.isLoadingAmount = true

        self.service.getAmount { result in
            DispatchQueue.main.async {
                self.isLoadingAmount = false
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let amount):
                    self.amount = amount
                }
            }
        }

        self.service.getStatement { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let statement):
                DispatchQueue.main.async {
//                    self.statementList = statement
                }
            }
        }
    }

    func showHideButtonPressed() {
        hideAmount.toggle()
        UserDefaults.standard.setValue(hideAmount, forKey: "HideAmount")
    }
}
