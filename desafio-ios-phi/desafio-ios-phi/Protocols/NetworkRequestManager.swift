//
//  NetworkRequestManager.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 19/05/21.
//

import Foundation
protocol NetworkRequestManager {
    func request(router: Router, completion: @escaping (Result<Data?, NetWorkResponseError>) -> Void)
}
