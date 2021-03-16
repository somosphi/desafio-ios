//
//  TransactionsCell.swift
//  DesafioPhi
//
//  Created by Lucas Siqueira on 11/03/21.
//

import Foundation
import UIKit

/**
 Célula com as labels referentes às informações da transação
 */
class TransactionsViewCell: UITableViewCell{
    //MARK: Views
    
    /// Label que indica o tipo da transação
    @IBOutlet weak var typeTransaction: UILabel!
    /// Label que indica o favorecido (quem recebeu a transação)
    @IBOutlet weak var favored: UILabel!
    /// Label que indica o valor da transação
    @IBOutlet weak var amount: UILabel!
    /// Label que indica se a transação é do tipo PIX
    @IBOutlet weak var pix: UILabel!
    /// Label que indica a data da transação
    @IBOutlet weak var date: UILabel!
    /// Círculo que fica ao lado da cécula
    @IBOutlet weak var circleView: UIView!{
        didSet{
            super.layoutSubviews()
            circleView.layer.cornerRadius = circleView.bounds.size.width / 2
            circleView.layer.masksToBounds = true
        }
    }
    /// Constraint da linha vertical ao lado da célula
    @IBOutlet weak var lineConstraint: NSLayoutConstraint!
    
}
