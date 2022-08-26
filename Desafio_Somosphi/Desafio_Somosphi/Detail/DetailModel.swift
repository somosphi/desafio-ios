//
//  DetailModel.swift
//  Desafio_Somosphi
//
//  Created by Suh on 25/08/22.
//

import Foundation

class DetailModel {

    var detail: Statement?
    var service: DetailService?

    init(detail: Statement) {
        self.detail = detail
    }
    //    func getDetailStatement() {
    //        descriptionLabel.text = detail?.description
    //        valueLabel.text = Formatter.formatCurrency(value: detail!.amount)
    //        targetLabel.text = detail?.target
    //        bankLabel.text = detail?.bankName
    //        dateHourLabel.text = Formatter.formatDate(string: detail!.createdAt, from: .long, to: .long)
    //        // authenticationLabel.text = detail?.authentication
    //        // descriptionTargetLabel.text = detail?.typeTarget
    //    }
}

// https://desafio-mobile-bff.herokuapp.com/myStatement/detail/49E27207-F3A7-4264-B021-0188690F7D43
