//
//  DetailTableViewCell.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 14/01/21.
//

import UIKit

// MARK: - Class

final class DetailTableViewCell: UITableViewCell {
    
    // MARK: - Internal variables
    
    static let id = String(describing: self)
    
    // MARK: - Private variables
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .phiBlack
        view.font = UIFont.systemFont(ofSize: 14)
        view.text = "Título"
        return view
    }()
    
    private lazy var contentLabel: UILabel = {
        let view = UILabel()
        view.textColor = .phiBlack
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.text = "Conteúdo"
        view.numberOfLines = 0
        return view
    }()
    
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension DetailTableViewCell {
    
    // MARK: - Internal methods
    
    func setupCellText(title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        contentView.backgroundColor = .white
        
        contentView.addSubviews([titleLabel,
                                 contentLabel], constraints: true)
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor
                .constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            contentLabel.topAnchor
                .constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            contentLabel.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor, constant: -16),
            contentLabel.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
