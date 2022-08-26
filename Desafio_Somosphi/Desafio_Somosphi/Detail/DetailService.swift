//
//  DetailService.swift
//  Desafio_Somosphi
//
//  Created by Suh on 26/08/22.
//

import Foundation

class DetailService {

    enum ServiceError: Error {
        case noContent
    }

    private var network: Network?

    init(network: Network = Network.shared) {
        self.network = network
    }

    func fetchDetail(
        id: String,
        onComplete: @escaping (Statement) -> Void,
        onError: @escaping (Error) -> Void
    ) {

        let request = Request.init(
            baseURL: Config.baseURL,
            path: "myStatement/detail/\(id)",
            header: [Authentication.tokenField: Authentication.tokenValue],
            method: RequestMethod.get)

        network?.request(request: request, returning: Statement.self) { result in
            switch result {
            case .failure(let error):
                onError(error)
            case .success(let detail):
                guard let detail = detail else {
                    return
                }
                onComplete(detail)
            }
        }
    }

}

// https://desafio-mobile-bff.herokuapp.com/myStatement/detail/49E27207-F3A7-4264-B021-0188690F7D43
// basepath
// "myStatement/detail/ \(id)"
