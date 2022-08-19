//
//  ExtractService.swift
//  Desafio_Somosphi
//
//  Created by Suh on 11/08/22.
//

import Foundation

class AmountService {
    private let network: Network

    init(network: Network = Network.shared) {
        self.network = network
    }

    func fecthAmont(onComplete: @escaping (Amount) -> Void,
                    onError: @escaping (Error) -> Void
    ) {
        let request = Request.init(
            baseURL: Config.baseURL,
            path: "myBalance",
            method: RequestMethod.get
        )

        network.request(request: request, returning: Amount.self) { result in
            switch result {
            case .failure(let error):
                onError(error)
            case .success(let amount):
                onComplete(amount ?? Amount(amount: 0))
            }
        }

    }

}
