//
//  DetailView.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 12/01/21.
//

import UIKit

// MARK: - Class

final class DetailView: UIView {
    
    // MARK: - Private variables
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .phiGray
        return view
    }()
    
    // MARK: - Internal variables
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.id)
        view.separatorStyle = .none
        return view
    }()
    
    lazy var shareButton: UIButton = {
        let view = UIButton()
        view.setTitle("Compartilhar", for: .normal)
        view.tintColor = .white
        view.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        view.backgroundColor = .phiGreen
        return view
    }()
    
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
    
    private func setupLayout() {
        backgroundColor = .white
        
        addSubviews([lineView,
                     tableView,
                     shareButton], constraints: true)
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            lineView.heightAnchor
                .constraint(equalToConstant: 1),
            lineView.topAnchor
                .constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            lineView.leadingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            lineView.trailingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tableView.topAnchor
                .constraint(equalTo: lineView.bottomAnchor, constant: 16),
            tableView.leadingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor
                .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            shareButton.heightAnchor
                .constraint(equalToConstant: 40),
            shareButton.leadingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            shareButton.trailingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            shareButton.bottomAnchor
                .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
