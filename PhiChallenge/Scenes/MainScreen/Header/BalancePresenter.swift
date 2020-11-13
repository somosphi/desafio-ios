//
//  MyBalancePresenter.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 10/11/20.
//

import Foundation

final class BalancePresenter {
    //MARK: - Properties
    
    private let defaults = UserDefaults.standard
    
    private let myBalance: Int
    private weak var view: BalanceHeaderView?
    
    //MARK: - Initialization
    init(myBalance: Int) {
        self.myBalance = myBalance
    }
    
    //MARK: - Functions
    
    func attachView(_ view: BalanceHeaderView) {
        self.view = view
        
        view.setAmount(with: myBalance)
        
        if defaults.bool(forKey: "First Launch") == true {
            defaults.set(true, forKey: "First Launch")
            
        } else {
            defaults.setValue(Images.hideEye, forKey: K.eyeType)
            defaults.setValue(true, forKey: K.hideAmountView)
            defaults.setValue(false, forKey: K.hideAmountLabel)
            defaults.setValue(true, forKey: K.didTap)
            defaults.setValue(true, forKey: "First Launch")
        }
    }
    
    func shouldHideAmount() {
    
        if defaults.bool(forKey: K.didTap) == true {
            view?.hideAmount(with: true, image: Images.showEye)
            defaults.setValue(Images.showEye, forKey: K.eyeType)
            defaults.setValue(false, forKey: K.hideAmountView)
            defaults.setValue(true, forKey: K.hideAmountLabel)
            defaults.setValue(false, forKey: K.didTap)
            
        } else if defaults.bool(forKey: K.didTap) == false {
            view?.hideAmount(with: false, image: Images.hideEye)
            defaults.setValue(Images.hideEye, forKey: K.eyeType)
            defaults.setValue(true, forKey: K.hideAmountView)
            defaults.setValue(false, forKey: K.hideAmountLabel)
            defaults.setValue(true, forKey: K.didTap)
        }
    }
}

