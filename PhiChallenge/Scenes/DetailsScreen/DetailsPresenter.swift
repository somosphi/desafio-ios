//
//  DetailsPresenter.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 13/11/20.
//

import Foundation

final class DetailsPresenter {
    //MARK: - Properties
    
    weak var view: DetailsScreenView?
    private var details: Items?
    
    private var id: String
    private let service: DetailsServiceInput
    
    //MARK: - Initialization
    
    init(id: String, service: DetailsServiceInput) {
        self.id = id
        self.service = service
        
        service.outputDetails = self
    }
    
    //MARK: - Functions
    
    func viewDidLoad() {
        fetchStatementID()
    }
    
    func fetchStatementID() {
        view?.showLoader()
        service.fetchStatementID(id: id)
    }
    
    func tryAgain() {
        
        fetchStatementID()
    }
    
}

//MARK: - DetailsServiceOutput Interface Implementation

extension DetailsPresenter: DetailsServiceOutput {
 
    func didUpdateDetailsSuccess(_ response: Items) {
        
        details = response
        
        if let description = details?.description {
        
        view?.setDescription(with: description)
        }
        
        if let amount = details?.amount {
            
            let amountString = String(format: "R$ %.02i,00", amount)
            
            view?.setAmount(with: amountString)
        }
       
        if let to = details?.to {
            view?.setReceiver(with: to)
        }
        
        if let from = details?.from {
            view?.setReceiver(with: from)
        }
        
        if let bankName = details?.bankName {
        view?.setBankName(with: bankName)
        }
        
        if let createdAt = details?.createdAt {
        let createdAtFiltered = createdAt.removeCharacters(charactersOf: "TZ")
        let formattedDate = createdAtFiltered.dataFormatter(dateFormat: "yyyy-MM-dd HH:mm:ss",
                                                             dateToBeFormatted: "dd/MM/yyyy - HH:mm:ss")
        view?.setCreatedAt(with: formattedDate)
        }
        
        if let authentication = details?.authentication {
            
            let authNumbers = authentication.filterNumbers
            view?.setAuthentication(with: authNumbers)
        }
        
        view?.hideLoader()
    }

    func didUpdateDetailsFail(_ error: Error) {
        
        view?.showError(message: error.localizedDescription)
        view?.hideLoader()
    }
}
