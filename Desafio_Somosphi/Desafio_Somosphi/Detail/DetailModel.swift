//
//  DetailModel.swift
//  Desafio_Somosphi
//
//  Created by Suh on 25/08/22.
//

import Foundation

protocol DetailModelDelegate: AnyObject {
    func didUpShowDetail()
}

class DetailModel {

    private(set) var statement: Statement?
    private let statementID: String
    var service: DetailService?
    var delegate: DetailModelDelegate?

    init(statementID: String) {
        self.statementID = statementID
    }

    func loadDetail() {
        service?.fetchDetail(
            id: statementID,
            onComplete: { [weak self] result in
                self?.statement = result
                self?.delegate?.didUpShowDetail()
            },
            onError: { error in
                print(error.localizedDescription)
            })
    }

}

// https://desafio-mobile-bff.herokuapp.com/myStatement/detail/49E27207-F3A7-4264-B021-0188690F7D43
