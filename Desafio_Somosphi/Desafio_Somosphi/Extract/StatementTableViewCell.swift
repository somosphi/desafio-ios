//
//  StatementTableViewCell.swift
//  Desafio_Somosphi
//
//  Created by Suh on 04/08/22.
//

import UIKit

class StatementTableViewCell: UITableViewCell {

    @IBOutlet weak var typeMovementLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pixImage: UIView!
    @IBOutlet weak var circleView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func prepare(model: Statement) {
        typeMovementLabel.text = model.description
        nameLabel.text = model.bankName
        amountLabel.text = Formatter.formatCurrency(value: model.amount)
        dateLabel.text = Formatter.formatDate(string: model.createdAt)
        pixImage.isHidden = false
        circleView.layer.cornerRadius = circleView.frame.size.height/2
    }
}
