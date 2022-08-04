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
//        switch self {
//        case .eye:
//            return UIImage(systemName: "eye.fill")
//        case .eyeSlash:
//            return UIImage(systemName: "eye.slash.fill")
//        }
        UIImage(systemName: self.rawValue)
    }

}
