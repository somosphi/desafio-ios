//
//  UIActivityIndicatorBuilder.swift
//  DesafioIOS
//
//

import UIKit

class UIActivityIndicatorBuilder{
    static func create(style : UIActivityIndicatorView.Style) -> UIActivityIndicatorView{
        let spinner = UIActivityIndicatorView()
        spinner.style = style
        spinner.hidesWhenStopped = true
        return spinner
    }

}

