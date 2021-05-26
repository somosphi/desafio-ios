//
//  ViewController.swift
//  Desafio-iOS
//
//  Created by Alex Freitas on 28/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountBar: UIView!
    @IBOutlet weak var showHideButton: UIButton!
    @IBOutlet weak var amountActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    var statementList: [StatementInfo] = []
    var statementInfo: StatementInfo?
    var spinner = UIActivityIndicatorView(style: .large)

    private var viewModel: ViewControllerViewModel = ViewControllerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.bindViewModelToController = bind

        amountLabel.text = nil
        amountBar.isHidden = true
        amountActivityIndicator.isHidden = true

        tableView.delegate = self
        tableView.dataSource = self

        spinner.translatesAutoresizingMaskIntoConstraints = true
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.center = view.center
    }

    func bind() {
        setupAmountView()
        tableView.reloadData()
    }

    @IBAction func showHideButtonPressed(_ sender: Any) {
        viewModel.showHideButtonPressed()
    }

    private func setupAmountView() {
        let imageName = viewModel.hideAmount ? "phiShow" : "phiHide"
        if let image = UIImage(named: imageName) {
            showHideButton.setImage(image, for: .normal)
        }

        amountLabel.text = viewModel.amountText
        amountBar.isHidden = viewModel.hideAmountBar

        if viewModel.isLoadingAmount {
            amountActivityIndicator.startAnimating()
            amountActivityIndicator.isHidden = false
        } else {
            amountActivityIndicator.stopAnimating()
            amountActivityIndicator.isHidden = true
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.statementList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = StatementInfoTableViewCell.identifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? StatementInfoTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(with: viewModel.statementList[indexPath.row])
        spinner.removeFromSuperview()

        return cell
    }
}

extension ViewController: UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        statementInfo = viewModel.statementList[indexPath.row]
        performSegue(withIdentifier: "statementDetailSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "statementDetailSegue" {
            guard let viewController = segue.destination as? StatementDetailViewController else {
                print(Error.self)
                return
            }
            viewController.statementInfo = statementInfo
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height-100-scrollView.frame.size.height) {
            viewModel.getMoreData()
        }
    }
}
