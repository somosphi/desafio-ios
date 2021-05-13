//
//  TintableImage.swift
//  Desafio-iOS
//
//  Created by Alex Freitas on 03/05/21.
//

import Foundation
import UIKit

func tintImage(image: UIImage) -> UIImage {
    let tintableImage = image.withRenderingMode(.alwaysTemplate)
    return tintableImage
}
