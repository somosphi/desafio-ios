//
//  StatementCellPresenter.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 10/11/20.
//

import Foundation

final class StatementCellPresenter {
    //MARK: - Properties
    
    private let myStatements: Items
    private weak var view: StatementCellView?
    
    //MARK: - Initialization
    
    init(myStatements: Items) {
        self.myStatements = myStatements
    }
    
    //MARK: - Functions
    
    func attachView(_ view: StatementCellView) {
        self.view = view
        
        view.setAmount(with: myStatements.amount)
        view.setDescription(with: myStatements.description)
        setReceiver()
        setCreatedAt()
        shouldShowPixFlag()
    }
    
    func setCreatedAt() {
        
        let createdAt = myStatements.createdAt
        let createdAtFiltered = createdAt.removeCharacters(charactersOf: "TZ")
        let formattedDate = createdAtFiltered.dataFormatter(dateFormat: "yyyy-MM-dd HH:mm:ss",
                                                            dateToBeFormatted: "dd/MM")
        view?.setCreatedAt(with: formattedDate)
    }
    
    func setReceiver() {
        if let receiver = myStatements.from {
            view?.setReceiver(with: receiver)
        } else if let receiver = myStatements.to {
            view?.setReceiver(with: receiver)
        }
    }
    
    private enum TransferType: String {
    case pixIn = "PIXCASHIN"
    case pixOut = "PIXCASHOUT"
    }

    func shouldShowPixFlag() {
        
        let pixFlag = myStatements.tType
        
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


