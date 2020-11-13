//
//  StatementCell.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 10/11/20.
//

import UIKit

final class StatementCell: UITableViewCell {
    //MARK: - Properties
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGrayHex
        
        return view
    }()
    
    private let ballView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyanHex
        view.layer.cornerRadius = 7
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blackHex
        label.textAlignment = .left
        label.font = UIFont(name: Fonts.arial, size: 16)
        
        return label
    }()
    
    private let receiverlabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGrayHex
        label.textAlignment = .left
        label.font = UIFont(name: Fonts.arial, size: 15)
        
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blackHex
        label.textAlignment = .left
        label.font = UIFont(name: Fonts.KohinoorBanglaSemiBold, size: 16)
        
        return label
    }()
    
    private let createAtlabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGrayHex
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.arial, size: 16)
        
        return label
    }()
    
    private let pixFlagLabel: UILabel = {
        let label = UILabel()
        label.text = K.pix
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.arial, size: 12)
        label.backgroundColor = .cyanHex
        label.isHidden = true
        
        return label
    }()
    
    
    static let identifier = "StatementCell"

    //MARK: - Initialization
    
override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        setupViewConfiguration()
        setup()
}

required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
    
    //MARK: - Functions
    
    func attachPresenter(_ presenter: StatementCellPresenter) {
        presenter.attachView(self)
    }
    
   
    private func setup() {
        backgroundColor = .white
    }
    
    
}
//MARK: - StatementCellView Interface Implementation
extension StatementCell: StatementCellView {
    
    func setDescription(with text: String) {
        descriptionLabel.text = text
    }
    
    func setReceiver(with text: String) {
        receiverlabel.text = text
    }
    
    func setAmount(with value: Int) {
        amountLabel.text = String(format: "R$ %.02i,00", value)
    }
    
    func setCreatedAt(with text: String) {
        createAtlabel.text = text
    }
    
    func showPixFlag(with flag: Bool) {
        pixFlagLabel.isHidden = !flag
    }
    
}

//MARK: - ViewConfiguration
extension StatementCell: ViewConfiguration {
    
    func setupConstraints() {
        
        lineView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            lineView.heightAnchor.constraint(equalTo: heightAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 1)
        ])
        
        ballView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            ballView.centerXAnchor.constraint(equalTo: lineView.centerXAnchor),
            ballView.centerYAnchor.constraint(equalTo: lineView.centerYAnchor),
            ballView.widthAnchor.constraint(equalToConstant: 14),
            ballView.heightAnchor.constraint(equalToConstant: 14)
        ])
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: lineView.trailingAnchor, constant: 20),
        ])
        
        receiverlabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            receiverlabel.topAnchor.constraint(equalTo: ballView.topAnchor),
            receiverlabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
        ])
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: receiverlabel.bottomAnchor, constant: 10),
            amountLabel.leadingAnchor.constraint(equalTo: receiverlabel.leadingAnchor),
        ])
        
        createAtlabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            createAtlabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            createAtlabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
        
        pixFlagLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pixFlagLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            pixFlagLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            pixFlagLabel.widthAnchor.constraint(equalToConstant: 50),
            pixFlagLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    func buildViewHierarchy() {
        addSubview(lineView)
        addSubview(descriptionLabel)
        addSubview(ballView)
        addSubview(receiverlabel)
        addSubview(amountLabel)
        addSubview(createAtlabel)
        addSubview(pixFlagLabel)
        
    }
  
}
