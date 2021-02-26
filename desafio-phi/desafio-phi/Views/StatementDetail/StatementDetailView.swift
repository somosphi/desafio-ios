//
//  StatementDetailView.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 26/02/21.
//

import UIKit

final class StatementDetailView: UIView {
    
    // MARK: - Private variables
    
    //MARK: - Internal variables
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupLayout()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatementDetailView {
    
    //MARK: - Internal methods
    
    // MARK: - Private methods
    private func setupLayout() {
        backgroundColor = .red
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}

