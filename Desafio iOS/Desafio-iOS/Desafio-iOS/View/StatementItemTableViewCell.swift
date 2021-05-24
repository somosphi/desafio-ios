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

    static let identifier = "StatementItem"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(with statementInfo: StatementInfo) {
        self.transferTypeLabel.text = statementInfo.tType
        self.transferValueLabel.text = String(statementInfo.amount)
        self.transferDate.text = statementInfo.createdAt
    }
}
