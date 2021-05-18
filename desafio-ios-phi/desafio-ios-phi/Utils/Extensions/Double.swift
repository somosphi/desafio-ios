//
//  Double.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 03/05/21.
//

import Foundation

extension Double {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
