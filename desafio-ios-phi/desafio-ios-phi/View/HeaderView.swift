//
//  HeaderView.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 03/05/21.
//

import Foundation
import UIKit

class HeaderView: UIView {
    
    // MARK: - Properties
    
    private var isAmountHidden: Bool = UserDefaultsPersistence.shared.getIsAmountHidden()
    private let hiddenAmountImage = UIImage(systemName: "eye.slash.fill")
    private let shownAmountImage = UIImage(systemName: "eye.fill")
    
    // MARK: - Views
    
    private let amountDescriptionLabel: UILabel = {
        let amountDescriptionLabel = UILabel()
        amountDescriptionLabel.text = "Seu saldo"
        amountDescriptionLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        amountDescriptionLabel.textColor = .blackTextColor
        return amountDescriptionLabel
    }()
    
    private let titleLabel: UILabel = MyLabel(textColor: .blackTextColor,
                                              font: UIFont.boldSystemFont(ofSize: 17),
                                              text: "Suas movimentações",
                                              alignment: .left)
    
    private let amountLabel: UILabel = MyLabel(textColor: .lightGreenColor,
                                               font: UIFont.boldSystemFont(ofSize: 25),
                                               alignment: .left)

    private let viewForHiddenAmount: UIView = {
        let viewForHiddenAmount = UIView()
        viewForHiddenAmount.backgroundColor = .lightGreenColor
        return viewForHiddenAmount
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
    
    var customBackgroundView: UIView = {
        let customBackgroundView = UIView()
        customBackgroundView.backgroundColor = .whiteOffColor
        return customBackgroundView
    }()
    
    // MARK: - Inicialization
    
    public init() {
        super.init(frame: .zero)
        
        UserDefaultsPersistence.shared.setupUserPreference()
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    @objc func hideAmount() {
        isAmountHidden = !isAmountHidden
        hideAmountButton.setImage(isAmountHidden ? hiddenAmountImage : shownAmountImage, for: .normal)
        viewForHiddenAmount.isHidden = !isAmountHidden
        amountLabel.isHidden = isAmountHidden
        UserDefaultsPersistence.shared.setIsAmountHidden(value: isAmountHidden)
        layoutSubviews()
    }
    
    func updateAmount(_ text: String) {
        amountLabel.text = text
        layoutIfNeeded()
    }
    
    // MARK: - Setup Constraints
    
    private func setupCustomBackgroundConstraints() {
        customBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            customBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customBackgroundView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
    
        ])
        
    }
    
    private func setupHorizontalStackConstraints() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: 16),
            horizontalStackView.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor, constant: 16)
            
        ])
    }

    private func setupAmountLabelConstraints() {
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 16),
            amountLabel.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor, constant: 16)
        ])
        
    }
    
    private func setupViewForHiddenAmountConstraints() {
        viewForHiddenAmount.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewForHiddenAmount.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor,
                                                     constant: 20),
            viewForHiddenAmount.leadingAnchor.constraint(equalTo: horizontalStackView.leadingAnchor),
            viewForHiddenAmount.widthAnchor.constraint(equalToConstant: 120),
            viewForHiddenAmount.heightAnchor.constraint(equalToConstant: 5)
            
        ])
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: customBackgroundView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
        
    }
}

// MARK: - ViewConfiguration

extension HeaderView: ViewConfiguration {
    
    func configureViews() {
        backgroundColor = .white
        hideAmountButton.addTarget(self, action: #selector(hideAmount), for: .touchUpInside)
        hideAmountButton.setImage(isAmountHidden ? hiddenAmountImage : shownAmountImage, for: .normal)
        viewForHiddenAmount.isHidden = !isAmountHidden
        amountLabel.isHidden = isAmountHidden
    }
    
    func buildViewHierarchy() {
        horizontalStackView.addArrangedSubview(amountDescriptionLabel)
        horizontalStackView.addArrangedSubview(hideAmountButton)
        
        addSubview(customBackgroundView)
        addSubview(horizontalStackView)
        addSubview(viewForHiddenAmount)
        addSubview(amountLabel)
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        setupCustomBackgroundConstraints()
        setupHorizontalStackConstraints()
        setupAmountLabelConstraints()
        setupViewForHiddenAmountConstraints()
        setupTitleLabelConstraints()
    }
    
}
