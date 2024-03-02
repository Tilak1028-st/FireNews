//
//  NewsDetailViewController.swift
//  FireNews
//
//  Created by Tilak Shakya on 01/03/24.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var newsArticleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    
    // MARK: - Properties
    
    var article: Articles?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareInitialView()
    }
    
    private func prepareInitialView() {
        // Make rounded corners for the article image view
        self.newsArticleImageView.layer.cornerRadius = 10
        
        // Populate UI elements with article data
        self.titleLabel.text = article?.title ?? "No title available"
        self.descriptionLabel.text = article?.description ?? "No description available"
        self.authorLabel.text = article?.author ?? "No author available"
        self.sourceLabel.text = article?.source?.name ?? "No Source available"
        self.publishedAtLabel.text = convertDateString(article?.publishedAt ?? "")
        
        // Load article image if available
        if let imageUrlString = article?.urlToImage, let imageUrl = URL(string: imageUrlString) {
            newsArticleImageView.kf.setImage(with: imageUrl)
        } else {
            newsArticleImageView.image = nil
        }
    }
}

extension NewsDetailViewController {
    func convertDateString(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
