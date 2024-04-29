//
//  ArticleTableViewCell.swift
//  Articles
//
//  Created by VijayaLakshmi Tatiparthi on 29/04/24.
//
import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setArticleData(articleData: ArticleModel) {
        titleLabel.text = articleData.title
        if let imageString = articleData.url {
            let url = URL(string: imageString) ?? URL(fileURLWithPath: "")
            setImage(from: url)
        }
    }
    
    func setImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.commentImageView.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
