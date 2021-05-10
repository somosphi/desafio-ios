//
//  StatementsHeaderView.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 04/05/21.
//

import UIKit
class StatementsHeaderView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Suas movimentações"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .blackTextColor
        label.numberOfLines = 0
        return label
    }()
    
    public init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatementsHeaderView: ViewConfiguration {
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)

        ])
    }
    
    func buildViewHierarchy() {
        addSubview(titleLabel)
    }
    func configureViews() {
        backgroundColor = .white
    }
    
}
