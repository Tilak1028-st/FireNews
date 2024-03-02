//
//  APIClient.swift
//  FireNews
//
//  Created by Tilak Shakya on 01/03/24.
//

import Foundation

// Enum to represent various API-related errors
enum APIError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
}

// Class responsible for handling API requests
class APIClient {
    
    // Method to fetch data from a given URL
    func fetch<T: Decodable>(urlString: String, responseType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL)) // Handle invalid URL case
            return
        }
        
        // Initiating a data task to fetch data from the URL
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.serverError(error.localizedDescription))) // Handle server error case
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData)) // Handle no data case
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse)) // Completion with success
            } catch {
                completion(.failure(.decodingError)) // Handle decoding error case
            }
            
        }.resume()
    }
}
