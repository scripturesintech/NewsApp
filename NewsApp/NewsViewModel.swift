//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Roopesh Tripathi on 25/07/24.
//

import Foundation
import Observation

@Observable
class NewsViewModel {
    private let newsService: NewsServiceable
    var articles: [Article] = []
    var error: String?

    init(newsService: NewsServiceable) {
        self.newsService = newsService
    }

    func fetchNews() async {
        do {
            articles = try await newsService.fetchNews()
        } catch let networkError as NetworkError {
            self.error = networkError.localizedDescription
        } catch {
            self.error = NetworkError.unknown.localizedDescription
        }
    }
}
