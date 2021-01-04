//
//  StatementCell.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 31/12/20.
//

import UIKit

class StatementCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var lineTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var typeLabel: BaseLabel!
    @IBOutlet weak var pixView: UIView!
    @IBOutlet weak var fromLabel: SmallGreyLabel!
    @IBOutlet weak var dateLabel: MediumGrayLabel!
    @IBOutlet weak var valueLabel: MediumSemiboldLabel!
    
    // MARK: - Setup
    
    var item: Item? {
        didSet{
            guard let item = item else { return }
            mainBackgroundView.backgroundColor = item.isPix() ? .appLightGray : .white
            typeLabel.text = item.description
            pixView.isHidden = !(item.isPix())
            fromLabel.text = item.getCorrectlyFromString()
            dateLabel.text = item.createdAt?.getDayMonthFormat()
            valueLabel.text = item.getCorrectlyAmount().getReaisValue() 
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
