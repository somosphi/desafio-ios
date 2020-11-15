//
//  StatementCellPresenter.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 10/11/20.
//

import Foundation

final class StatementCellPresenter {
    //MARK: - Properties
    
    private let statements: Items
    private weak var view: StatementCellView?
    
    //MARK: - Initialization
    
    init(statements: Items) {
        self.statements = statements
    }
    
    //MARK: - Functions
    
    func attachView(_ view: StatementCellView) {
        self.view = view
        
        view.setAmount(with: String(format: "R$ %.02i,00", statements.amount))
        view.setDescription(with: statements.description)
        setReceiver()
        setCreatedAt()
        shouldShowPixFlag()
    }
    
    func setCreatedAt() {
        
        let createdAt = statements.createdAt
        let createdAtFiltered = createdAt.removeCharacters(charactersOf: "TZ")
        let formattedDate = createdAtFiltered.dataFormatter(dateFormat: "yyyy-MM-dd HH:mm:ss",
                                                            dateToBeFormatted: "dd/MM")
        view?.setCreatedAt(with: formattedDate)
    }
    
    func setReceiver() {
        if let receiver = statements.from {
            view?.setReceiver(with: receiver)
        } else if let receiver = statements.to {
            view?.setReceiver(with: receiver)
        }
    }
    
    private enum TransferType: String {
    case pixIn = "PIXCASHIN"
    case pixOut = "PIXCASHOUT"
    }

    func shouldShowPixFlag() {
        
        let pixFlag = statements.tType
        
        switch pixFlag {
        case TransferType.pixIn.rawValue:
             view?.showPixFlag(with: true)
        case TransferType.pixOut.rawValue:
             view?.showPixFlag(with: true)
        default:
            view?.showPixFlag(with: false)
        }
    }
}


