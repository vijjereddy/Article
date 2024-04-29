//
//  BaseViewController.swift
//  Articles
//
//  Created by VijayaLakshmi Tatiparthi on 29/04/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlertPopup(message: String? = "Something went wrong, please try again!") {
        let uialert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil)
        uialert.addAction(action)
        self.present(uialert, animated: true, completion: nil)
    }
    
    func startAnimating() {
        activityIndicator.color = UIColor(named: "app_red_color")
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }

}
