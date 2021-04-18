//
//  MyStatetementViewModel.swift
//  DesafioIOS
//
//

import Foundation
import Combine

class MyStatementViewModel{
    
    // MARK: - Model
    private var statementItems = [MyStatementItem]()
    
    // MARK: - Observables to be subscribed by view
    var statementItemsObservable : AnyPublisher<Result<[MyStatementItem],
                                          StatementLoadErrorViewModel>,Never>{
        return statementItemsSubject.eraseToAnyPublisher()
    }
    private let statementItemsSubject = PassthroughSubject<Result<[MyStatementItem],
                                                             StatementLoadErrorViewModel>,Never>()
    
    var myBalanceObservable : AnyPublisher<Result<MyBalance, StatementLoadErrorViewModel>,Never>{
        return myBalanceSubject.eraseToAnyPublisher()
    }
    private let myBalanceSubject = PassthroughSubject<Result<MyBalance, StatementLoadErrorViewModel>,Never>()
    
    var showBalanceSettingsObservable : AnyPublisher<Bool,Never>{
        return showBalanceSettingsSubject.eraseToAnyPublisher()
    }
    private let showBalanceSettingsSubject = CurrentValueSubject<Bool,Never>(UserSettings.shared.showBalance)
    
    var isLoadingStatementsItemsObservable : AnyPublisher<Bool,Never>{
        return isLoadingStatementsItemsSubject.eraseToAnyPublisher()
    }
    private let isLoadingStatementsItemsSubject = CurrentValueSubject<Bool,Never>(false);
    
    // MARK: - ApiCaller
    private let apiCaller : ApiCallerProtocol
    
    // MARK: - Initialization
    init(apiCaller : ApiCallerProtocol){
        self.apiCaller = apiCaller
    }
    
    // Fetch Statements from API
    func fetchStatements(){
        guard !isLoadingStatementsItemsSubject.value else { return }
        isLoadingStatementsItemsSubject.send(true)
        apiCaller.fetchMyStatement(numberOfItems: 10, offset: (statementItems.count - 1) / 10)
        {[weak self] result in
            guard let self = self else { return }
            defer{self.isLoadingStatementsItemsSubject.send(false)}
            switch(result){
                case .success(let myStatement):
                    let statementItems = myStatement.items.map{statementResponse in
                        MyStatementItem(statementResponse: statementResponse,
                                                     statementDateFormatter: StatementDateFormatter.shared,
                                                     moneyFormatter: MoneyFormatter.shared)
                    }
                    self.statementItems.append(contentsOf: statementItems)
                    self.statementItemsSubject.send(.success(self.statementItems))
                case .failure:
                    self.statementItemsSubject.send(.failure(StatementLoadErrorViewModel.loadStatementsError))
            }
        }
    }
    
    // Fetch balance from API
    func fetchBalance(){
        apiCaller.fetchMyBalance{[weak self] result in
            switch(result){
                case .success(let myBalanceResponse):
                    self?.myBalanceSubject.send(.success(MyBalance(myBalanceResponse: myBalanceResponse, moneyFormatter: MoneyFormatter.shared)))
                    
                case .failure:
                    self?.myBalanceSubject.send(.failure(StatementLoadErrorViewModel.loadBalanceError))
            }
        }
    }
    
    // Called by view when the show balance button is pressed
    func showBalanceButtonWasPressed(){
        let settingsValueToSave = !showBalanceSettingsSubject.value
        UserSettings.shared.showBalance = settingsValueToSave
        showBalanceSettingsSubject.send(settingsValueToSave)
    }
    
}
