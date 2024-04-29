//
//  ArticleViewController.swift
//  Articles
//
//  Created by VijayaLakshmi Tatiparthi on 28/04/24.
//

import UIKit

class ArticleViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var articleTableView: UITableView!
    
    var apiManager = APIManager()
    var articleData = [ArticleModel]()
    var pageNo = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleTableView.separatorStyle = .none
        fetchArticleData()
    }
        
}

//MARK:- API Calls
extension ArticleViewController {
    func fetchArticleData() {
        self.startAnimating()
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.apiManager.fetchArticleData(pageNo: self?.pageNo ?? 0, completionHandler: { [weak self] result, error in
                DispatchQueue.main.async {
                    if let articleData = result, articleData.count > 0 {
                        self?.pageNo += 1
                        self?.stopAnimating()
                        print(articleData)
                        self?.articleData.append(contentsOf: articleData)
                        self?.articleTableView.reloadData()
                    } else if let error = error {
                        self?.stopAnimating()
                        print(error)
                        self?.showAlertPopup()
                    }
                }
            })
        }
    }

}

//MARK:- TableView Delegate and datasources
extension ArticleViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        cell.selectionStyle = .none
        cell.setArticleData(articleData: articleData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == articleData.count - 1 {
            fetchArticleData()
        }
    }
    
}
