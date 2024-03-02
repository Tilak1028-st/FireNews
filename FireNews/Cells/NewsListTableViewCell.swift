//
//  NewsListTableViewCell.swift
//  FireNews
//
//  Created by Tilak Shakya on 02/03/24.
//

import UIKit
import Kingfisher

class NewsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articelImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var newsArticle: Articles? {
        didSet {
            self.titleLabel.text = newsArticle?.title ?? "No Title Available"
            if let imageUrlString = newsArticle?.urlToImage, let imageUrl = URL(string: imageUrlString) {
                articelImageView.kf.setImage(with: imageUrl)
            } else {
                articelImageView.image = nil
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        articelImageView.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
