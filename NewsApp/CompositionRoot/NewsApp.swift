//
//  NewsApp.swift
//  NewsApp
//
//  Created by Roopesh Tripathi on 25/07/24.
//

import SwiftUI

@main
struct NewsApp: App {
    var body: some Scene {
        WindowGroup {
            let networkManager = NetworkManager()
            let newsService = NewsService(networkManager: networkManager)
            let viewModel = NewsViewModel(newsService: newsService)
            ArticleListView(viewModel: viewModel)
        }
    }
}
