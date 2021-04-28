//
//  StatementViewController.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import UIKit

class StatementViewController: UIViewController {
    var startDetail: (() -> Void)?
    
    let buttonTest: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        button.backgroundColor = .blue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Extrato"
       
        buttonTest.addTarget(self, action: #selector(presentDetail), for: .touchUpInside)
        view.addSubview(buttonTest)
      
        buttonTest.translatesAutoresizingMaskIntoConstraints = false
        buttonTest.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        buttonTest.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    @objc func presentDetail() {
        startDetail?()
    }
}
