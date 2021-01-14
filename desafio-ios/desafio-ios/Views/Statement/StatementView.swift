//
//  StatementView.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 12/01/21.
//

import UIKit

final class StatementView: UIView {
    
    // MARK: - Private variables
    
    private lazy var myBalanceLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        view.textColor = .phiBlack
        view.text = "Seu saldo"
        return view
    }()
    
    private lazy var tableViewHeaderLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        view.textColor = .phiBlack
        view.text = "Suas movimentações"
        return view
    }()
    
    private lazy var balanceView: UIView = {
        let view = UIView()
        view.backgroundColor = .phiOffWhite
        return view
    }()
    
    private lazy var tableViewHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var hiddenView: UIView = {
        let view = UIView()
        view.backgroundColor = .phiGreen
        view.alpha = 0
        return view
    }()
    
    // MARK: - Internal variables
    
    lazy var amountLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        view.textColor = .phiGreen
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.register(StatementTableViewCell.self, forCellReuseIdentifier: StatementTableViewCell.id)
        view.separatorStyle = .none
        return view
    }()
    
    lazy var revealButton: UIButton = {
        let view = UIButton()
        view.tintColor = .phiGreen
        return view
    }()
    
    var isAmountHidden: Bool
    
    // MARK: - Initializers
    
    init() {
        self.isAmountHidden = UserDefaults.standard.bool(forKey: "isAmountHidden")
        
        super.init(frame: .zero)
        
        setupLayout()
        createConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        self.isAmountHidden = UserDefaults.standard.bool(forKey: "isAmountHidden")
        
        super.init(coder: aDecoder)
    }
}

extension StatementView {
    
    // MARK: - Private methods
    
    private func changeRevealButtonImage() {
        if isAmountHidden {
            amountLabel.alpha = 0
            hiddenView.alpha = 1
            revealButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            
            UserDefaults.standard.set(isAmountHidden, forKey: "isAmountHidden")
        } else {
            amountLabel.alpha = 1
            hiddenView.alpha = 0
            revealButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            UserDefaults.standard.set(isAmountHidden, forKey: "isAmountHidden")
        }
    }
    
    private func setupLayout() {
        backgroundColor = .white
        
        changeRevealButtonImage()
        
        addSubviews([balanceView,
                     tableViewHeaderView,
                     tableView], constraints: true)
        
        balanceView.addSubviews([myBalanceLabel, amountLabel, revealButton, hiddenView], constraints: true)
        
        tableViewHeaderView.addSubview(tableViewHeaderLabel, constraints: true)
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            balanceView.topAnchor
                .constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            balanceView.leadingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            balanceView.trailingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            myBalanceLabel.topAnchor
                .constraint(equalTo: balanceView.topAnchor, constant: 16),
            myBalanceLabel.leadingAnchor
                .constraint(equalTo: balanceView.leadingAnchor, constant: 16),
            
            amountLabel.topAnchor
                .constraint(equalTo: myBalanceLabel.bottomAnchor, constant: 8),
            amountLabel.leadingAnchor
                .constraint(equalTo: balanceView.leadingAnchor, constant: 16),
            amountLabel.bottomAnchor
                .constraint(equalTo: balanceView.bottomAnchor, constant: -16),
            
            hiddenView.topAnchor
                .constraint(equalTo: amountLabel.topAnchor, constant: 12),
            hiddenView.leadingAnchor
                .constraint(equalTo: amountLabel.leadingAnchor),
            hiddenView.bottomAnchor
                .constraint(equalTo: amountLabel.bottomAnchor, constant: -12),
            hiddenView.trailingAnchor
                .constraint(equalTo: amountLabel.trailingAnchor),
            
            revealButton.topAnchor
                .constraint(equalTo: balanceView.topAnchor, constant: 16),
            revealButton.leadingAnchor
                .constraint(equalTo: myBalanceLabel.trailingAnchor, constant: 8),
            revealButton.bottomAnchor
                .constraint(equalTo: amountLabel.topAnchor, constant: -8),
            revealButton.heightAnchor
                .constraint(equalToConstant: 14),
            revealButton.widthAnchor
                .constraint(equalToConstant: 20),
            
            tableViewHeaderView.topAnchor
                .constraint(equalTo: balanceView.bottomAnchor),
            tableViewHeaderView.leadingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableViewHeaderView.trailingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            tableViewHeaderLabel.topAnchor
                .constraint(equalTo: tableViewHeaderView.topAnchor, constant: 16),
            tableViewHeaderLabel.leadingAnchor
                .constraint(equalTo: tableViewHeaderView.leadingAnchor, constant: 16),
            tableViewHeaderLabel.trailingAnchor
                .constraint(equalTo: tableViewHeaderView.trailingAnchor, constant: -16),
            tableViewHeaderLabel.bottomAnchor
                .constraint(equalTo: tableViewHeaderView.bottomAnchor, constant: -16),
            
            tableView.topAnchor
                .constraint(equalTo: tableViewHeaderView.bottomAnchor),
            tableView.leadingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor
                .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - Internal methods
    
    func toggleRevealButton() {
        isAmountHidden.toggle()
        changeRevealButtonImage()
    }
}
