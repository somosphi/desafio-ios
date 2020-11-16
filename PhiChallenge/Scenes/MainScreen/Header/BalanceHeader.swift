//
//  myBalanceHeaderView.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 10/11/20.
//

import UIKit

final class BalanceHeader: UIView {
    //MARK: - Properties
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = MainHeaders.yourAmount
        label.textColor = .blackHex
        label.textAlignment = .left
        label.font = UIFont(name: Fonts.arialMT, size: 16)
        
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: Fonts.KohinoorBanglaSemiBold, size: 26)
        label.textColor = .cyanHex
        
        return label
    }()
    
    private let eyeButton: UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = .clear
        imageview.contentMode = .scaleToFill
        imageview.isUserInteractionEnabled = true
        
        return imageview
    }()
    
    private let hideAmountView: UIView = {
        let imageView = UIView()
        imageView.backgroundColor = .cyanHex
        
        return imageView
    }()
    
    private var presenter: BalanceHeaderPresenter?
    
    private let defaults = UserDefaults.standard
    
    
    //MARK: -  Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViewConfiguration()
        setup()
        actions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    private func actions() {
        eyeButton.addTapGesture(with: self, action: #selector(eyeButtonDidTap))
    }
    
    //MARK: - Functions
    
    private func setup() {
        backgroundColor = .lightGrayHex
    }
    
    func attachPresenter(_ presenter: BalanceHeaderPresenter) {
        presenter.attachView(self)
        self.presenter = presenter
        
        amountLabel.isHidden = defaults.bool(forKey: DefaultsKey.isAmountHide)
        hideAmountView.isHidden = !defaults.bool(forKey: DefaultsKey.isAmountHide)
        
        eyeButton.image = UIImage(named: defaults.string(forKey: DefaultsKey.eyeType) ?? Images.hideEye)
    }
    
    //MARK: - Objective-C Method
    
    @objc func eyeButtonDidTap() {
        presenter?.shouldHideAmount()
    }
}

//MARK: - BalanceHeaderView Interface Implementation

extension BalanceHeader: BalanceHeaderView {
    
    func setAmount(with text: String) {
        amountLabel.text = text
    }
    
    func hideAmount(with flag: Bool, image: String) {
        
        eyeButton.image = UIImage(named: image)
        hideAmountView.isHidden = !flag
        amountLabel.isHidden = flag

    }
}

//MARK: - ViewConfiguration

extension BalanceHeader: ViewConfiguration {
    func setupConstraints() {
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            balanceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            balanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
        
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 10),
            amountLabel.leadingAnchor.constraint(equalTo: balanceLabel.leadingAnchor)
        ])
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eyeButton.leadingAnchor.constraint(equalTo: balanceLabel.trailingAnchor, constant: 10),
            eyeButton.centerYAnchor.constraint(equalTo: balanceLabel.centerYAnchor),
            eyeButton.heightAnchor.constraint(equalToConstant: 20),
            eyeButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        hideAmountView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hideAmountView.centerXAnchor.constraint(equalTo: amountLabel.centerXAnchor),
            hideAmountView.centerYAnchor.constraint(equalTo: amountLabel.centerYAnchor),
            hideAmountView.heightAnchor.constraint(equalToConstant: 5),
            hideAmountView.widthAnchor.constraint(equalTo: amountLabel.widthAnchor)
        ])
        
    }
    
    func buildViewHierarchy() {
        addSubview(balanceLabel)
        addSubview(amountLabel)
        addSubview(eyeButton)
        addSubview(hideAmountView)
    }
}
