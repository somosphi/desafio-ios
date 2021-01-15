//
//  StatementTableViewCell.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 13/01/21.
//

import UIKit

// MARK: - Class

final class StatementTableViewCell: UITableViewCell {
    
    // MARK: - Internal variables
    
    static let id = String(describing: self)
    
    // MARK: - Private variables
    
    private lazy var transferTypeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.textColor = .phiBlack
        view.text = "Transferência enviada"
        return view
    }()
    
    private lazy var forLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textColor = .phiGray
        view.text = "David Bond"
        return view
    }()
    
    private lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        view.textColor = .phiBlack
        view.text = "R$ 18,00"
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textColor = .phiGray
        view.text = "10/10"
        return view
    }()
    
    private lazy var pixLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        view.textColor = .white
        view.text = "Pix"
        return view
    }()
    
    private lazy var upperView: UIView = {
        let view = UIView()
        view.backgroundColor = .phiGray
        return view
    }()
    
    private lazy var lowerView: UIView = {
        let view = UIView()
        view.backgroundColor = .phiGray
        return view
    }()
    
    private lazy var circleView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "circle.fill")
        view.tintColor = .phiGreen
        return view
    }()
    
    private lazy var designView = UIView()
    
    private lazy var pixView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.backgroundColor = .phiGreen
        view.isHidden = true
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(transferTypeLabel)
        view.addArrangedSubview(forLabel)
        view.addArrangedSubview(valueLabel)
        view.axis = .vertical
        view.alignment = .top
        view.distribution = .fillEqually
        view.spacing = 6
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

extension StatementTableViewCell {
    
    // MARK: - Internal methods
    
    func setupLabel(statement: Statement) {
        transferTypeLabel.text = statement.transferenceType
        forLabel.text = statement.to
        dateLabel.text = statement.createdAt.formatDate(inputSymbols: "yyyy-MM-dd'T'HH:mm:ss'Z'", outputSymbols: "dd/MM")
        valueLabel.text = statement.amountToString
        
        if statement.tType.contains("PIX") {
            pixView.isHidden = false
            backgroundColor = .phiOffWhite
        }
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        contentView.backgroundColor = .white
        
        addSubviews([designView,
                     stackView,
                     pixView,
                     dateLabel], constraints: true)
        
        designView.addSubviews([circleView,
                     upperView,
                     lowerView], constraints: true)
        
        pixView.addSubview(pixLabel, constraints: true)
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            designView.topAnchor
                .constraint(equalTo: contentView.topAnchor),
            designView.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor),
            designView.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor),
            
            circleView.centerYAnchor
                .constraint(equalTo: designView.centerYAnchor),
            circleView.leadingAnchor
                .constraint(equalTo: designView.leadingAnchor, constant: 16),
            circleView.trailingAnchor
                .constraint(equalTo: designView.trailingAnchor, constant: -16),
            circleView.heightAnchor
                .constraint(equalToConstant: 12),
            circleView.widthAnchor
                .constraint(equalToConstant: 12),
            
            upperView.topAnchor
                .constraint(equalTo: designView.topAnchor),
            upperView.bottomAnchor
                .constraint(equalTo: circleView.topAnchor, constant: -2),
            upperView.centerXAnchor
                .constraint(equalTo: designView.centerXAnchor),
            upperView.widthAnchor
                .constraint(equalToConstant: 1),
            
            lowerView.topAnchor
                .constraint(equalTo: circleView.bottomAnchor, constant: 2),
            lowerView.bottomAnchor
                .constraint(equalTo: designView.bottomAnchor),
            lowerView.centerXAnchor
                .constraint(equalTo: designView.centerXAnchor),
            lowerView.widthAnchor
                .constraint(equalToConstant: 1),
            
            pixView.topAnchor
                .constraint(equalTo: contentView.topAnchor, constant: 4),
            pixView.trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            pixLabel.topAnchor
                .constraint(equalTo: pixView.topAnchor, constant: 4),
            pixLabel.leadingAnchor
                .constraint(equalTo: pixView.leadingAnchor, constant: 4),
            pixLabel.trailingAnchor
                .constraint(equalTo: pixView.trailingAnchor, constant: -4),
            pixLabel.bottomAnchor
                .constraint(equalTo: pixView.bottomAnchor, constant: -4),
            
            stackView.topAnchor
                .constraint(equalTo: contentView.topAnchor, constant: 4),
            stackView.leadingAnchor
                .constraint(equalTo: designView.trailingAnchor),
            stackView.trailingAnchor
                .constraint(equalTo: dateLabel.leadingAnchor, constant: 16),
            
            dateLabel.centerYAnchor
                .constraint(equalTo: contentView.centerYAnchor),
            dateLabel.trailingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}
