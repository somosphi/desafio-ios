//
//  Request.swift
//  Desafio_Somosphi
//
//  Created by Suh on 11/08/22.
//

import Foundation

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol RequestProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
}

struct Request: RequestProtocol {
    var baseURL: String
    var path: String
    var method: RequestMethod
}
