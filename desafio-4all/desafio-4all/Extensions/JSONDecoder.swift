//
//  JSONDecoder.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import Foundation

extension JSONDecoder {
    func decodeWithDate<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        self.dateDecodingStrategy = .formatted(dateFormatter)
        return try self.decode(type, from: data)
    }
}
