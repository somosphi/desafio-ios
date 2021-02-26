//
//  StatementView.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 25/02/21.
//

import UIKit

final class StatementView: UIView {
    
    // MARK: - Private variables
    private lazy var myBalanceView: UIView = {
        let view = UIView()
        view.backgroundColor = .appOffWhite
        return view
    }()
    
    private lazy var balanceTitle: PHILabel = {
        let view = PHILabel(text: "Seu saldo",
                            fontStyle: .subheadline,
                            font: .systemFont(ofSize: 16, weight: .regular))
        return view
    }()
    
    private lazy var balanceCurrency: PHILabel = {
        let view = PHILabel(fontStyle: .title3,
                            font: .systemFont(ofSize: 24, weight: .bold))
        view.textColor = .appGreen
        return view
    }()
    
    private lazy var hiddenView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGreen
        view.alpha = 0
        return view
    }()
    
    private lazy var tableViewHeader: PHILabel = {
        let view = PHILabel(text: "Suas movimentações",
                            fontStyle: .headline,
                            font: .systemFont(ofSize: 16, weight: .bold))
        return view
    }()
    
    //MARK: - Internal variables
    lazy var eyeButton: UIButton = {
        let view = UIButton()
        view.tintColor = .appGreen
        view.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        view.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(StatementTableViewCell.self, forCellReuseIdentifier: StatementTableViewCell.id)
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
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

extension StatementView {
    
    //MARK: - Internal methods
    func toggleBalanceVisibility() {
        eyeButton.isSelected = !eyeButton.isSelected
        
        balanceCurrency.alpha = eyeButton.isSelected ? 0 : 1
        hiddenView.alpha = eyeButton.isSelected ? 1 : 0
    }
    
    func setBalanceAmount(value: Double) {
        balanceCurrency.text = "R$ \(value)"
    }
    
    // MARK: - Private methods
    private func setupLayout() {
        backgroundColor = .white
        
        addSubviews([myBalanceView, tableViewHeader, tableView], constraints: true)
        myBalanceView.addSubviews([balanceTitle, balanceCurrency, eyeButton, hiddenView], constraints: true)
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            
            myBalanceView.topAnchor
                .constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            myBalanceView.leadingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            myBalanceView.trailingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            balanceTitle.topAnchor
                .constraint(equalTo: myBalanceView.topAnchor, constant: 20),
            balanceTitle.leadingAnchor
                .constraint(equalTo: myBalanceView.leadingAnchor, constant: 20),
            
            eyeButton.centerYAnchor
                .constraint(equalTo: balanceTitle.centerYAnchor),
            eyeButton.leadingAnchor
                .constraint(equalTo: balanceTitle.trailingAnchor, constant: 20),
            
            balanceCurrency.topAnchor
                .constraint(equalTo: balanceTitle.bottomAnchor, constant: 20),
            balanceCurrency.leadingAnchor
                .constraint(equalTo: balanceTitle.leadingAnchor),
            balanceCurrency.bottomAnchor
                .constraint(equalTo: myBalanceView.bottomAnchor, constant: -20),
            
            hiddenView.centerYAnchor
                .constraint(equalTo: balanceCurrency.centerYAnchor),
            hiddenView.centerXAnchor
                .constraint(equalTo: balanceCurrency.centerXAnchor),
            hiddenView.widthAnchor
                .constraint(equalTo: balanceCurrency.widthAnchor),
            hiddenView.heightAnchor
                .constraint(equalToConstant: 5),
            
            tableViewHeader.topAnchor
                .constraint(equalTo: myBalanceView.bottomAnchor, constant: 20),
            tableViewHeader.leadingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            tableView.topAnchor
                .constraint(equalTo: tableViewHeader.bottomAnchor, constant: 20),
            tableView.bottomAnchor
                .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tableView.leadingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
