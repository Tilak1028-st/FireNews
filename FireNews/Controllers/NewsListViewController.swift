//
//  NewsListViewController.swift
//  FireNews
//
//  Created by Tilak Shakya on 01/03/24.
//

import UIKit

class NewsListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var newsListTableView: UITableView!
    
    // MARK: - Properties
    var newsViewModel = NewsListViewModel()
    let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareInitialView()
        fetchNews()
        setupActivityIndicator()
        setupRefreshControl()
    }
    
    
    private func prepareInitialView() {
        // Registering the table view cell
        newsListTableView.register(UINib(nibName: FNConstant.newsListTableViewCell, bundle: nil), forCellReuseIdentifier: FNConstant.newsListTableViewCell)
    }
    
    private func setupRefreshControl() {
        // Adding refresh control to table view
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        newsListTableView.refreshControl = refreshControl
    }
    
    private func setupActivityIndicator() {
        // Adding activity indicator to view
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    @objc private func refreshData() {
        // Refreshing news data
        fetchNews()
    }
    
    
    private func fetchNews() {
        activityIndicator.startAnimating()
        newsViewModel.fetchNews { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let news):
                print(news)
                DispatchQueue.main.async {
                    self.newsListTableView.reloadData()
                    self.refreshControl.endRefreshing()
                    self.activityIndicator.stopAnimating()
                }
                
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
}

// MARK: - TableView Delegate and DatasSource

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsViewModel.getArticles()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = newsListTableView.dequeueReusableCell(withIdentifier: FNConstant.newsListTableViewCell, for: indexPath) as! NewsListTableViewCell
        tableCell.selectionStyle = .none
        if let articles = newsViewModel.getArticles() {
            let article = articles[indexPath.item]
            tableCell.newsArticle = article
        }
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsDetailVC = self.storyboard?.instantiateViewController(withIdentifier: FNConstant.newsDetailViewController) as! NewsDetailViewController
        
        if let articles = newsViewModel.getArticles() {
            let article = articles[indexPath.item]
            newsDetailVC.article = article
        }
        self.navigationController?.pushViewController(newsDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
