//
//  DetailView.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 12/01/21.
//

import UIKit

// MARK: - Class

final class DetailView: UIView {
    
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

extension DetailView {
    
    // MARK: - Private methods
    
    private func setupLayout() {}
    
    private func createConstraints() {}
}
