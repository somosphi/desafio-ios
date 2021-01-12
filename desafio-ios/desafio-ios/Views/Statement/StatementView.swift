//
//  StatementView.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 12/01/21.
//

import UIKit

final class StatementView: UIView {
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setupLayout()
        createConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension StatementView {
    
    // MARK: - Private methods
    
    private func setupLayout() {}
    
    private func createConstraints() {}
}
