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
        return view
    }()
    
    private lazy var hiddenView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGreen
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
    
    // MARK: - Private methods
    private func setupLayout() {
        backgroundColor = .white
        
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([

        ])
    }
}
