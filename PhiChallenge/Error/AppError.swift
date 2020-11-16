//
//  AppError.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 09/11/20.
//

import Foundation

enum AppError: Error {
    case generic
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .generic: return "Ops, something went wrong. Try again later."
        }
    }
}
