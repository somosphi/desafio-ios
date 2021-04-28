//
//  NetworkResponse.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 28/04/21.
//

import Foundation
enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}
