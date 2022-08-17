//
//  Icon.swift
//  Desafio_Somosphi
//
//  Created by Suh on 03/08/22.
//

import UIKit

enum Icon: String {
    case eye = "eye.fill"
    case eyeSlash = "eye.slash.fill"

    var sfIcon: UIImage? {
        UIImage(systemName: self.rawValue)
    }

}
