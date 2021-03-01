//
//  StatementDetailTableViewCell.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 01/03/21.
//

import UIKit

final class StatementDetailTableViewCell: UITableViewCell {
    
    static let id = String(describing: self)
    
    //MARK: - Private variables
    private lazy var titleLabel: PHILabel = {
        let view = PHILabel(textColor: .appBlack,
                            fontStyle: .footnote,
                            font: .systemFont(ofSize: 14, weight: .bold))
        return view
    }()
    
    private lazy var descriptionLabel: PHILabel = {
        let view = PHILabel(textColor: .appBlack,
                            fontStyle: .subheadline,
                            font: .systemFont(ofSize: 16, weight: .regular))
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        view.axis = .vertical
        view.spacing = 10
        view.alignment = .leading
        return view
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatementDetailTableViewCell {
    
    //MARK: - Internal methods
    func setupCell(title: String, description: String) {
        setupDefaultCell()
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    // MARK: - Private methods
    private func setupDefaultCell() {
        titleLabel.text = ""
        descriptionLabel.text = ""
    }
    
    private func setupLayout() {
        backgroundColor = .white
        
        addSubview(stackView, constraints: true)
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            
            stackView.topAnchor
                .constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            stackView.leadingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor
                .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15),
        ])
    }
}

