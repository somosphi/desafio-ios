//
//  StatementItemTableViewCell.swift
//  Desafio-iOS
//
//  Created by Alex Freitas on 23/05/21.
//

import UIKit

class StatementInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var transferDate: UILabel!
    @IBOutlet weak var transferTypeLabel: UILabel!
//    @IBOutlet weak var transferToLabel: UILabel!
    @IBOutlet weak var transferValueLabel: UILabel!
    @IBOutlet weak var pixIndicator: UILabel!

    static let identifier = "StatementItem"

    override func awakeFromNib() {
        super.awakeFromNib()
        pixIndicator.isHidden = true
    }

    public func configure(with statementInfo: StatementInfo) {
        let transferType = statementInfo.tType.description
        let transferValue = FormatterHelper.brCurrency(value: statementInfo.amount)
        let transferDate = FormatterHelper.shortDate(date: statementInfo.createdAt)

        self.transferTypeLabel.text = transferType
        self.transferValueLabel.text = transferValue
        self.transferDate.text = transferDate

        if transferType.range(of: "pix", options: .caseInsensitive) != nil {
            self.pixIndicator.isHidden = false
            self.backgroundColor = UIColor(named: "phiWhite")
        }
    }
}
