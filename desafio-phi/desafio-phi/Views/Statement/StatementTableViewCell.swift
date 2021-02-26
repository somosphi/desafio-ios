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
    
    private lazy var circleView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "circle.fill")
        view.tintColor = .appGreen
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
        return view
    }()
    
    private lazy var amountLabel: PHILabel = {
        let view = PHILabel(text: "R$ 20,00",
                            textColor: .appBlack,
                            fontStyle: .footnote,
                            font: .systemFont(ofSize: 14, weight: .bold))
        return view
    }()
    
    private lazy var dateLabel: PHILabel = {
        let view = PHILabel(text: "10/10",
                            textColor: .appGrey,
                            fontStyle: .subheadline,
                            font: .systemFont(ofSize: 16, weight: .regular))
        return view
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
    
    private lazy var labelsStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [transferLabel, forLabel, amountLabel])
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 5
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

extension StatementTableViewCell {
    
    //MARK: - Internal methods
    func setupCell(transferText: String, forText: String, value: String, date: String ,isPix: Bool) {
        setupDefaultCell()
        transferLabel.text = transferText
        forLabel.text = forText
        amountLabel.text = value
        dateLabel.text = date
        showPixLabel(show: isPix)
    }
    
    // MARK: - Private methods
    private func setupDefaultCell() {
        transferLabel.text = ""
        forLabel.text = ""
        amountLabel.text = ""
        dateLabel.text = ""
        showPixLabel(show: false)
    }
    
    private func setCircleViewCornerRadius() {
        circleView.layer.cornerRadius = circleView.frame.size.width / 2
        circleView.clipsToBounds = true
    }
    
    private func showPixLabel(show: Bool) {
        pixLabel.alpha = show ? 1 : 0
    }
    
    private func setupLayout() {
        backgroundColor = .white
        
        addSubviews([upperCircleLine, circleView, lowerCircleLine,
                     labelsStack, pixLabel, dateLabel], constraints: true)
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            
            circleView.centerYAnchor
                .constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            circleView.leadingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            circleView.widthAnchor
                .constraint(equalToConstant: 15),
            circleView.heightAnchor
                .constraint(equalToConstant: 15),
            
            upperCircleLine.centerXAnchor
                .constraint(equalTo: circleView.centerXAnchor),
            upperCircleLine.topAnchor
                .constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            upperCircleLine.bottomAnchor
                .constraint(equalTo: circleView.topAnchor),
            upperCircleLine.widthAnchor
                .constraint(equalToConstant: 1),
            
            lowerCircleLine.centerXAnchor
                .constraint(equalTo: circleView.centerXAnchor),
            lowerCircleLine.topAnchor
                .constraint(equalTo: circleView.bottomAnchor),
            lowerCircleLine.bottomAnchor
                .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            lowerCircleLine.widthAnchor
                .constraint(equalToConstant: 1),
            
            labelsStack.topAnchor
                .constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            labelsStack.leadingAnchor
                .constraint(equalTo: circleView.trailingAnchor, constant: 20),
            labelsStack.bottomAnchor
                .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            labelsStack.trailingAnchor
                .constraint(lessThanOrEqualTo: dateLabel.leadingAnchor, constant: -10),
            
            dateLabel.centerYAnchor
                .constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            dateLabel.trailingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            pixLabel.centerXAnchor
                .constraint(equalTo: dateLabel.centerXAnchor),
            pixLabel.centerYAnchor
                .constraint(equalTo: labelsStack.topAnchor),
            pixLabel.widthAnchor
                .constraint(equalTo: dateLabel.widthAnchor),
            pixLabel.heightAnchor
                .constraint(equalToConstant: 20),
            pixLabel.bottomAnchor
                .constraint(lessThanOrEqualTo: dateLabel.topAnchor),
        ])
    }
}
