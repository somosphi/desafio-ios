//
//  StatementViewController.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 12/01/21.
//

import Foundation

// MARK: - Class

final class StatementViewController: BaseViewController<StatementView> {
    
    // MARK: - Private variables
    
    private let viewModel: StatementViewModel
    
    // MARK: - Initializer
    
    init(viewModel: StatementViewModel) {
        self.viewModel = viewModel
        super.init()
    }
}

extension StatementViewController {}
