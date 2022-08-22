//
//  StatementService.swift
//  Desafio_Somosphi
//
//  Created by Suh on 22/08/22.
//

import Foundation

class StatementService {
    private let network: Network?

    init(network: Network = Network.shared) {
        self.network = network
    }

    func fetchStatements(
        onComplete: @escaping (Statements) -> Void,
        onError: @escaping (Error) -> Void
    ) {
        let request = Request.init(
            baseURL: Config.baseURL,
            path: "myStatement/10/1",
            header: [Authentication.tokenField: Authentication.tokenValue],
            method: RequestMethod.get
        )

        network?.request(request: request, returning: Statements.self) { result in
            switch result {
            case .failure(let error):
                onError(error)
            case .success(let items):
                onComplete(items ?? Statements(items: []))
            }
        }

    }

}
