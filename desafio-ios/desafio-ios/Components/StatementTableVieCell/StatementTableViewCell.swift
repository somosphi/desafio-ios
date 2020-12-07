//
//  StatementTableViewCell.swift
//  desafio-ios
//
//  Created by Alexandre Scheer Bing on 07/12/20.
//

import UIKit

class StatementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var transferenceTypeLabel: UILabel!
    
    @IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var pixLabel: UILabel!
    
    let pixTransference: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pixLabel.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(transferenceType: String, subject: String, value: String, date: String, isPixTransfer: Bool = false){
        if isPixTransfer {
            self.backgroundColor = UIColor(named: "LightGray")
            pixLabel.isHidden = false
        }
        transferenceTypeLabel.text = transferenceType
        subjectLabel.text = subject
        valueLabel.text = value
        dateLabel.text = date
    }

}
