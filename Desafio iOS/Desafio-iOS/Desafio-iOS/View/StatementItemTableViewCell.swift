//
//  StatementItemTableViewCell.swift
//  Desafio-iOS
//
//  Created by Alex Freitas on 23/05/21.
//

import UIKit

class StatementInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var transferDateLabel: UILabel!
    @IBOutlet weak var transferTypeLabel: UILabel!
    @IBOutlet weak var transferInfoLabel: UILabel!
    @IBOutlet weak var transferValueLabel: UILabel!
    @IBOutlet weak var pixIndicator: UILabel!

    static let identifier = "StatementItem"

    override func awakeFromNib() {
        super.awakeFromNib()
        pixIndicator.isHidden = true
    }

    public func configure(with statementInfo: StatementInfo) {
        let transferType = statementInfo.description
        let transferValue = FormatterHelper.brCurrency(value: statementInfo.amount)
        let transferDate = FormatterHelper.shortDate(date: statementInfo.createdAt)

        transferTypeLabel.text = transferType
        transferValueLabel.text = transferValue
        transferDateLabel.text = transferDate
        transferInfoLabel.text = statementInfo.from ?? statementInfo.to

        if transferType.range(of: "pix", options: .caseInsensitive) != nil {
            pixIndicator.isHidden = false
            self.backgroundColor = UIColor(named: "phiWhite")
        } else {
            pixIndicator.isHidden = true
            self.backgroundColor = .white
        }
    }
}
