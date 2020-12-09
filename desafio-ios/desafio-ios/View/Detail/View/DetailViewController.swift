//
//  DetailViewController.swift
//  desafio-ios
//
//  Created by Alexandre Scheer Bing on 09/12/20.
//

import UIKit

class DetailViewController: UIViewController {

    static func instantiate(with viewModel: DetailViewModel) -> DetailViewController {
        let storyboard = UIStoryboard(name: "DetailView", bundle: .main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController else {
            return DetailViewController()
            
        }
        viewController.viewModel = viewModel
        return viewController
    }
    
    private var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("hello")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
