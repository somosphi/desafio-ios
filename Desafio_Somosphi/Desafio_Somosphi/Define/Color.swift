//
//  Color.swift
//  Desafio_Somosphi
//
//  Created by Suh on 24/08/22.
//

import Foundation
import UIKit

enum Color: String {
    case highlight
    case action
    case description
    case text

    var uiColor: UIColor? {
        return UIColor(named: self.rawValue)
    }
}
