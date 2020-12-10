//
//  DetailViewController.swift
//  desafio-ios
//
//  Created by Alexandre Scheer Bing on 09/12/20.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {

    static func instantiate(with viewModel: DetailViewModel) -> DetailViewController {
        let storyboard = UIStoryboard(name: "DetailView", bundle: .main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController else {
            return DetailViewController()
            
        }
        viewController.viewModel = viewModel
        return viewController
    }
    
    @IBOutlet weak var transferTypeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var payerOrReceiverLabel: UILabel!
    @IBOutlet weak var payerReceiverLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authLabel: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var printView: UIView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    let disposeBag = DisposeBag()
    var name: String = ""
    var id: String = ""
    var transference: String = ""
    
    private var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.retrieveAuth().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] element in
            self?.spinner.stopAnimating()
            self?.transferTypeLabel.text = element.transferenceType
            self?.payerReceiverLabel.text = ((element.to ?? element.from) ?? element.bankName) ?? "Sem infornação"
            self?.amountLabel.text = element.amountString
            self?.dateLabel.text = element.createdAt
            self?.authLabel.text = element.authentication
            UIView.animate(withDuration: 0.5){
                self?.printView.alpha = 1
                self?.shareButton.alpha = 1
            }
        })
        .disposed(by: disposeBag)
    }
    
    func takeScreenshot(of view: UIView) {
          UIGraphicsBeginImageContextWithOptions(
              CGSize(width: view.bounds.width, height: view.bounds.height),
              false,
              2
          )

          view.layer.render(in: UIGraphicsGetCurrentContext()!)
          let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
          UIGraphicsEndImageContext()

          UIImageWriteToSavedPhotosAlbum(screenshot, self, #selector(imageWasSaved), nil)
      }
    
    @IBAction func share(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: printView.bounds.width, height: printView.bounds.height),
            false,
            2
        )
        printView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        let activityViewController = UIActivityViewController(activityItems: [screenshot as Any], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func imageWasSaved(_ image: UIImage, error: Error?, context: UnsafeMutableRawPointer) {
        if let error = error {
            print(error.localizedDescription)
            return
        }

        print("Image was saved in the photo gallery")
        UIApplication.shared.open(URL(string:"photos-redirect://")!)
    }
    
}
