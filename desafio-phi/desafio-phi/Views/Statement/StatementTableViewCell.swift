//
//  StatementTableViewCell.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 25/02/21.
//

import UIKit

final class StatementTableViewCell: UITableViewCell {
    
    static let id = String(describing: self)
    
    //MARK: - Private variables
    private lazy var upperCircleLine: UIView = {
        let view = UIView()
        view.backgroundColor = .appGrey
        return view
    }()
    
    private lazy var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGreen
        return view
    }()
    
    private lazy var lowerCircleLine: UIView = {
        let view = UIView()
        view.backgroundColor = .appGrey
        return view
    }()
    
    private lazy var transferLabel: PHILabel = {
        let view = PHILabel(text: "Transferencia",
                            fontStyle: .subheadline,
                            font: .systemFont(ofSize: 16, weight: .regular))
        return view
    }()
    
    private lazy var forLabel: PHILabel = {
        let view = PHILabel(text: "Sua conta",
                            textColor: .appGrey,
                            fontStyle: .footnote,
                            font: .systemFont(ofSize: 14, weight: .regular))
    }()
    
    private lazy var amountLabel: PHILabel = {
        let view = PHILabel(text: "R$ 20,00",
                            textColor: .appBlack,
                            fontStyle: .footnote,
                            font: .systemFont(ofSize: 14, weight: .bold))
    }()
    
    private lazy var dateLabel: PHILabel = {
        let view = PHILabel(text: "10/10",
                            textColor: .appGrey,
                            fontStyle: .subheadline,
                            font: .systemFont(ofSize: 16, weight: .regular))
    }()
    
    private lazy var pixLabel: PHILabel = {
        let view = PHILabel(text: "Pix",
                            textColor: .white,
                            fontStyle: .caption2,
                            font: .systemFont(ofSize: 10, weight: .semibold))
        view.backgroundColor = .appGreen
        view.textAlignment = .center
        return view
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        createConstraints()
        setCircleViewCornerRadius()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatementTableViewCell {
    
    // MARK: - Private methods
    private func setCircleViewCornerRadius() {
        circleView.layer.cornerRadius = circleView.frame.size.width / 2
        circleView.clipsToBounds = true
    }
    
    private func setupLayout() {
        backgroundColor = .white
        
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([

        ])
    }
}
