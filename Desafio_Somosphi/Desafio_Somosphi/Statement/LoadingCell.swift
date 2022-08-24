//
//  LoadingCell.swift
//  Desafio_Somosphi
//
//  Created by Suh on 24/08/22.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet weak var activityView: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        activityView.startAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
