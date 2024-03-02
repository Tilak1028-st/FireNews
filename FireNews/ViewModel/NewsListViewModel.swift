//
//  NewsListViewModel.swift
//  FireNews
//
//  Created by Tilak Shakya on 01/03/24.
//

// View model class responsible for fetching news data
class NewsListViewModel {
    private let apiClient = APIClient()
    var articles: [Articles]?
    
    // Method to fetch news data
    func fetchNews(completion: @escaping (Result<Void, APIError>) -> Void) {
        let urlString = "https://newsapi.org/v2/everything?q=top&apiKey=347cad4449aa4efe85b00f5b3dd5e095"
        apiClient.fetch(urlString: urlString, responseType: NewsModel.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let news):
                self.articles = news.articles // Store fetched articles
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Method to retrieve stored articles
    func getArticles() -> [Articles]? {
        return articles
    }
}
