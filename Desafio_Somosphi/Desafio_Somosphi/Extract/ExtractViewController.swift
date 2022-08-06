//
//  ViewController.swift
//  Desafio_Somosphi
//
//  Created by Suh on 02/08/22.
//

import UIKit

class ExtractViewController: UIViewController {

    @IBOutlet weak var textBalanceLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    weak var coordinator: ExtractCoordinator?

    var movements = ["Brent Berg", "Cody Preston", "Kareem Dixon", "Xander Clark",
                    "Francis Frederick", "Carson Hopkins", "Anthony Nguyen", "Dean Franklin",
                    "Jeremy Davenport", "Rigel Bradford", "John Ball", "Zachery Norman",
                    "Valentine Lindsey", "Slade Thornton", "Jelani Dickson", "Vance Hurley",
                    "Wayne Ellison", "Kasimir Mueller", "Emery Pruitt", "Lucius Lawrence",
                    "Kenneth Mendez"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
    }

}

extension ExtractViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell.textLabel?.text = movements[indexPath.row]
        return cell
    }

}
