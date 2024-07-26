//
//  Article.swift
//  NewsApp
//
//  Created by Roopesh Tripathi on 25/07/24.
//

import Foundation

struct NewsResponse: Decodable {
    let articles: [Article]
}

struct Article: Identifiable, Decodable {
    var id: String {
        return url // Assuming `url` is unique for each article
    }
    let title: String
    let description: String?
    let urlToImage: String?
    let url: String
}
