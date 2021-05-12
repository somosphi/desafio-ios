//
//  StatementTableViewCell.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import UIKit

class StatementTableViewCell: UITableViewCell {
    static let reusableIdentifier = "StatementTableViewCell"
    
    var leftLine: UIView = {
        let line = UIView()
        line.backgroundColor = .blackTextColor
        return line
    }()
    
    var circleInLine: UIView = {
        let circle = UIView()
        circle.backgroundColor = .blackTextColor
        circle.clipsToBounds = true
        circle.backgroundColor = .lightGreenColor
        circle.layer.cornerRadius = 6
        circle.layer.borderColor = UIColor.white.cgColor
        circle.layer.borderWidth = 2
        return circle
    }()
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .blackTextColor
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .grayTextColor
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    var amountLabel: UILabel = {
        let amountLabel = UILabel()
        amountLabel.font = UIFont.boldSystemFont(ofSize: 17)
        amountLabel.textAlignment = .left
        amountLabel.numberOfLines = 0
        amountLabel.textColor = .blackTextColor
        return amountLabel
    }()
    
    var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .grayTextColor
        dateLabel.textAlignment = .center
        dateLabel.numberOfLines = 0
        return dateLabel
    }()
    
    var customBackgroundView: UIView = {
        let customBackgroundView = UIView()
        customBackgroundView.backgroundColor = .whiteOffColor
        return customBackgroundView
    }()
    
    var pixLabel: UILabel = {
        let pixLabel = UILabel()
        pixLabel.text = "Pix"
        pixLabel.font = UIFont.systemFont(ofSize: 15)
        pixLabel.textColor = .white
        pixLabel.backgroundColor = .lightGreenColor
        pixLabel.textAlignment = .center
        return pixLabel
    }()

    func setup(statementDetail: StatementDetailViewModel) {
        titleLabel.text = statementDetail.description
        nameLabel.text = statementDetail.userName
        dateLabel.text = statementDetail.dateResume
        
        if let amount = statementDetail.amount {
            switch statementDetail.type {
            case .PIXCASHOUT, .TRANSFEROUT:
                amountLabel.text = "-" + amount
            default:
                amountLabel.text = amount
            }
        }
        
        switch statementDetail.type {
        case .PIXCASHOUT, .PIXCASHIN:
            pixLabel.isHidden = false
            customBackgroundView.isHidden = false
        default:
            pixLabel.isHidden = true
            customBackgroundView.isHidden = true
        }
        
        setupViewConfiguration()
    }
    
    private func setupLineDetailConstraints() {
        leftLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            leftLine.heightAnchor.constraint(equalTo: heightAnchor),
            leftLine.widthAnchor.constraint(equalToConstant: 0.3),
            leftLine.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupCustomBackgroundConstraints() {
        customBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            customBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    private func setupPixLabelConstraints() {
        pixLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pixLabel.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: 10),
            pixLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            pixLabel.widthAnchor.constraint(equalToConstant: 60),
            pixLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
        ])
    }
    
    private func setupDateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: pixLabel.bottomAnchor, constant: 10),
            dateLabel.centerXAnchor.constraint(equalTo: pixLabel.centerXAnchor)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leftLine.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: pixLabel.leadingAnchor, constant: -16)
        ])
    }
    
    private func setupNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: dateLabel.leadingAnchor, constant: -16)
        ])
    }
    
    private func setupCircleDetailConstraints() {
        circleInLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circleInLine.centerXAnchor.constraint(equalTo: leftLine.centerXAnchor),
            circleInLine.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            circleInLine.widthAnchor.constraint(equalToConstant: 12),
            circleInLine.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
  
    private func setupAmountLabelConstraints() {
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            amountLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            amountLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            amountLabel.bottomAnchor.constraint(equalTo: customBackgroundView.bottomAnchor, constant: -10)
        ])
    }
}

extension StatementTableViewCell: ViewConfiguration {
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
    }
    
    func setupConstraints() {
        setupLineDetailConstraints()
        setupCustomBackgroundConstraints()
        setupDateLabelConstraints()
        setupPixLabelConstraints()
        setupTitleLabelConstraints()
        setupNameLabelConstraints()
        setupCircleDetailConstraints()
        setupAmountLabelConstraints()
    }
    
    func buildViewHierarchy() {
        addSubview(customBackgroundView)
        addSubview(leftLine)
        addSubview(circleInLine)
        addSubview(titleLabel)
        addSubview(pixLabel)
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(amountLabel)
    }
}
