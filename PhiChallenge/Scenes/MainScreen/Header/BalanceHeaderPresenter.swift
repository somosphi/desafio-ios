//
//  MyBalancePresenter.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 10/11/20.
//

import Foundation

final class BalanceHeaderPresenter {
    //MARK: - Properties
    
    private let defaults = UserDefaults.standard
    
    private let balance: Int
    private weak var view: BalanceHeaderViewProtocol?
    
    //MARK: - Initialization
    
    init(balance: Int) {
        self.balance = balance
    }
    
    //MARK: - Functions
    
    func attachView(_ view: BalanceHeaderViewProtocol) {
        self.view = view
        
        view.setAmount(with: String(format: "R$ %.02i,00", balance))
        
        if defaults.bool(forKey: "First Launch") == true {
            defaults.set(true, forKey: "First Launch")
            
        } else {
            defaults.setValue(Images.hideEye, forKey: DefaultsKey.eyeType)
            defaults.setValue(false, forKey: DefaultsKey.isAmountHide)
           
            defaults.setValue(true, forKey: "First Launch")
        }
    }
    
    func shouldHideAmount() {
    
        if defaults.bool(forKey: DefaultsKey.isAmountHide) == false {
            
            view?.hideAmount(with: true, image: Images.showEye)
            
            defaults.setValue(Images.showEye, forKey: DefaultsKey.eyeType)
            defaults.setValue(true, forKey: DefaultsKey.isAmountHide)
         
        } else {
            
            view?.hideAmount(with: false, image: Images.hideEye)
            
            defaults.setValue(Images.hideEye, forKey: DefaultsKey.eyeType)
            defaults.setValue(false, forKey: DefaultsKey.isAmountHide)
        }
    }
}

