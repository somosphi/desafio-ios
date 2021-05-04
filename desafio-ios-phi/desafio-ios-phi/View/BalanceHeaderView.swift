//
//  BalanceHeaderView.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 03/05/21.
//

import Foundation
import UIKit

class BalanceHeaderView: UIView {
    
    private var isAmountHidden: Bool = UserDefaultsPersistence.shared.getIsAmountHidden()
    
    private let hiddenAmountImage = UIImage(systemName: "eye.slash.fill")
    private let shownAmountImage = UIImage(systemName: "eye.fill")
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Seu saldo"
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textColor = .blackTextColor
        return titleLabel
    }()
    
    private let viewForHiddenAmount: UIView = {
        let viewForHiddenAmount = UIView()
        viewForHiddenAmount.backgroundColor = .lightGreenColor
        return viewForHiddenAmount
    }()
    
    private let amountLabel: UILabel = {
        let amountLabel = UILabel()
        amountLabel.text = ""
        amountLabel.font = UIFont.boldSystemFont(ofSize: 25)
        amountLabel.textColor = .lightGreenColor
        return amountLabel
    }()
    
    private let hideAmountButton: UIButton = {
        let hideAmountButton = UIButton()
        hideAmountButton.tintColor = .lightGreenColor
        return hideAmountButton
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    
    public init() {
        super.init(frame: .zero)
        
        UserDefaultsPersistence.shared.setupUserPreference()
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func formatAmount(_ value: Double) -> String {
        return "R$ \(value.formattedWithSeparator)"
    }
    
    @objc func hideAmount() {
        isAmountHidden = !isAmountHidden
        hideAmountButton.setImage(isAmountHidden ? hiddenAmountImage : shownAmountImage, for: .normal)
        viewForHiddenAmount.isHidden = !isAmountHidden
        amountLabel.isHidden = isAmountHidden
        UserDefaultsPersistence.shared.setIsAmountHidden(value: isAmountHidden)
        layoutSubviews()
    }
    
    func updateAmount(_ value: Double) {
        amountLabel.text = formatAmount(value)
        layoutIfNeeded()
    }
}

extension BalanceHeaderView: ViewConfiguration {
    
    func configureViews() {
        backgroundColor = .whiteOffColor
        hideAmountButton.addTarget(self, action: #selector(hideAmount), for: .touchUpInside)
        hideAmountButton.setImage(isAmountHidden ? hiddenAmountImage : shownAmountImage, for: .normal)
        viewForHiddenAmount.isHidden = !isAmountHidden
        amountLabel.isHidden = isAmountHidden
    }
    
    func buildViewHierarchy() {
        horizontalStackView.addArrangedSubview(titleLabel)
        horizontalStackView.addArrangedSubview(hideAmountButton)
        
        addSubview(horizontalStackView)
        addSubview(viewForHiddenAmount)
        addSubview(amountLabel)
    }
    
    func setupConstraints() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        viewForHiddenAmount.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            amountLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 16),
            amountLabel.leadingAnchor.constraint(equalTo: horizontalStackView.leadingAnchor),
            amountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            viewForHiddenAmount.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor,
                                                     constant: 20),
            viewForHiddenAmount.leadingAnchor.constraint(equalTo: horizontalStackView.leadingAnchor),
            viewForHiddenAmount.widthAnchor.constraint(equalToConstant: 120),
            viewForHiddenAmount.heightAnchor.constraint(equalToConstant: 5)
            
        ])
        
    }
    
}
