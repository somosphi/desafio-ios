//
//  StatementDetailView.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 06/05/21.
//

import UIKit
class StatementDetailView: UIView {
    
    // MARK: - Views
    
    let titleLabel: UILabel = MyLabel(textColor: .blackTextColor,
                                      font: UIFont.boldSystemFont(ofSize: 17),
                                      alignment: .left)

    let subtitleLabel: UILabel = MyLabel(textColor: .blackTextColor,
                                         font: UIFont.systemFont(ofSize: 17),
                                         alignment: .left)

    // MARK: - Functions
    
    func configureLayout(title: String, subtitle: String) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        setupViewConfiguration()
    }
}

// MARK: - ViewConfiguration

extension StatementDetailView: ViewConfiguration {
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10)
        ])
    }
    
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    func configureViews() {
        backgroundColor = .white
    }
    
}
