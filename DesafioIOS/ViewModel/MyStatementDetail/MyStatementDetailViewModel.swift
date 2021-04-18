//
//  MyStatementDetailViewModel.swift
//  DesafioIOS
//
//

import Foundation
import Combine

class MyStatementDetailViewModel{
    // MARK: - Observable to be subscribed by view
    var itemDetailObservable : AnyPublisher<Result<MyStatementDetail,
                                                   StatementLoadErrorViewModel>,
                                            Never>{
        return itemDetailSubject.eraseToAnyPublisher()
    }
    
    private let itemDetailSubject = PassthroughSubject<Result<MyStatementDetail,
                                                              StatementLoadErrorViewModel>,
                                                       Never>()
    // MARK: - Model
    private let statementId : String
    private let apiCaller : ApiCallerProtocol
    
    // MARK: - Initialization
    init(apiCaller : ApiCallerProtocol, statementId : String){
        self.statementId = statementId
        self.apiCaller = apiCaller
    }
    
    // Fetch balance detail from model
    func fetchStatementDetail(){
        apiCaller.fetchMyStatementDetail(id: statementId){[weak self] response in
            guard let self = self else { return };
            switch(response){
                case .success(let detailResponse):
                    self.itemDetailSubject.send(
                        .success(
                            MyStatementDetail(myStatementDetailResponse: detailResponse,
                                              moneyFormatter: MoneyFormatter.shared,
                                              statementDateFormatter: StatementDateFormatter.shared)))
                    
                case .failure:
                    self.itemDetailSubject.send(.failure(StatementLoadErrorViewModel.loadDetailError))
            }
        }
    }
    
}
