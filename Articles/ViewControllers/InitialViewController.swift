//
//  ViewController.swift
//  Articles
//
//  Created by VijayaLakshmi Tatiparthi on 28/04/24.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionOnStartButton(_ sender: Any) {
        navigateToArticleVC()
    }
    
    func navigateToArticleVC() {
        let vc = storyboardInstance().instantiateViewController(withIdentifier: "ArticleViewController") as? ArticleViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func storyboardInstance() -> UIStoryboard {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        return storyBoard
    }
}

