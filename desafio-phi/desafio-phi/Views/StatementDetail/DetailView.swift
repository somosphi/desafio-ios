//
//  StatementDetailView.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 26/02/21.
//

import UIKit

final class StatementDetailView: UIView {
    
    // MARK: - Private variables
    private lazy var titleLabel: PHILabel = {
        let view = PHILabel(text: "Comprovante",
                            textColor: .appBlack,
                            fontStyle: .callout,
                            font: .systemFont(ofSize: 16, weight: .semibold))
        
        return view
    }()
    
    private lazy var titleSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGrey
        return view
    }()
    //MARK: - Internal variables
    
    lazy var imageToBeShared: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(StatementDetailTableViewCell.self, forCellReuseIdentifier: StatementDetailTableViewCell.id)
        view.separatorStyle = .none
        view.backgroundColor = .white
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    lazy var shareButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .appGreen
        view.setTitle("Compartilhar", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
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

extension StatementDetailView {
    
    //MARK: - Internal methods
    
    // MARK: - Private methods
    private func setupLayout() {
        backgroundColor = .white
        
        addSubviews([imageToBeShared, shareButton], constraints: true)
        imageToBeShared.addSubviews([titleLabel, titleSeparatorView, tableView], constraints: true)
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            
            imageToBeShared.topAnchor
                .constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageToBeShared.leadingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageToBeShared.trailingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            titleLabel.topAnchor
                .constraint(equalTo: imageToBeShared.topAnchor, constant: 10),
            titleLabel.centerXAnchor
                .constraint(equalTo: imageToBeShared.centerXAnchor),
            
            titleSeparatorView.topAnchor
                .constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            titleSeparatorView.leadingAnchor
                .constraint(equalTo: imageToBeShared.leadingAnchor, constant: 20),
            titleSeparatorView.trailingAnchor
                .constraint(equalTo: imageToBeShared.trailingAnchor, constant: -20),
            titleSeparatorView.heightAnchor
                .constraint(equalToConstant: 1),
            
            tableView.topAnchor
                .constraint(equalTo: titleSeparatorView.bottomAnchor, constant: 10),
            tableView.leadingAnchor
                .constraint(equalTo: titleSeparatorView.leadingAnchor),
            tableView.trailingAnchor
                .constraint(equalTo: titleSeparatorView.trailingAnchor),
            tableView.bottomAnchor
                .constraint(equalTo: imageToBeShared.bottomAnchor),
            
            shareButton.topAnchor
                .constraint(equalTo: imageToBeShared.bottomAnchor, constant: 20),
            shareButton.leadingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            shareButton.trailingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            shareButton.bottomAnchor
                .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),            
            shareButton.heightAnchor
                .constraint(equalToConstant: 50),
        ])
    }
}

