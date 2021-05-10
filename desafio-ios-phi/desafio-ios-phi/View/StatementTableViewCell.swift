//
//  StatementTableViewCell.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import UIKit

class StatementTableViewCell: UITableViewCell {
    static let reusableIdentifier = "StatementTableViewCell"
    
    var lineDetail: UIView = {
        let line = UIView()
        line.backgroundColor = .blackTextColor
        return line
    }()
    
    var circleDetail: UIView = {
        let circle = UIView()
        circle.backgroundColor = .blackTextColor
        circle.clipsToBounds = true
        circle.backgroundColor = .lightGreenColor
        circle.layer.cornerRadius = 7.5
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
        lineDetail.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lineDetail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lineDetail.heightAnchor.constraint(equalTo: heightAnchor),
            lineDetail.widthAnchor.constraint(equalToConstant: 0.5),
            lineDetail.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupCustomBackgroundConstraints() {
        customBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            customBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func setupPixLabelConstraints() {
        pixLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pixLabel.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: 10),
            pixLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
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
            titleLabel.leadingAnchor.constraint(equalTo: lineDetail.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: pixLabel.leadingAnchor, constant: -20)
        ])
    }
    
    private func setupNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: dateLabel.leadingAnchor, constant: -20)
        ])
    }
    
    private func setupCircleDetailConstraints() {
        circleDetail.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circleDetail.centerXAnchor.constraint(equalTo: lineDetail.centerXAnchor),
            circleDetail.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            circleDetail.widthAnchor.constraint(equalToConstant: 15),
            circleDetail.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
  
    private func setupAmountLabelConstraints() {
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            amountLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            amountLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
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
        addSubview(lineDetail)
        addSubview(circleDetail)
        addSubview(titleLabel)
        addSubview(pixLabel)
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(amountLabel)
    }
}
