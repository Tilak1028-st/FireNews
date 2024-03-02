//
//  NewsModel.swift
//  FireNews
//
//  Created by Tilak Shakya on 01/03/24.
//

import Foundation

// Struct to represent the model of news data
struct NewsModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Articles]?
}


// Struct to represent the source of news articles
struct Source: Codable {
    let id: String?
    let name: String?
}


// Struct to represent individual news articles
struct Articles: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
