//
//  ArticleListView.swift
//  NewsApp
//
//  Created by Roopesh Tripathi on 25/07/24.
//

import SwiftUI

struct ArticleListView: View {
    private var viewModel: NewsViewModel

    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            List(viewModel.articles) { article in
                NavigationLink(destination: ArticleDetailView(article: article)) {
                    newsCard(article: article)
                }
            }
            .navigationTitle("Top Headlines")
            .onAppear {
                Task {
                    await viewModel.fetchNews()
                }
            }
        }
    }
}

extension ArticleListView {
    @ViewBuilder
    func newsCard(article: Article) -> some View {
        VStack(alignment: .leading) {
            Text(article.title)
                .font(.headline)
                .underline()
            if let description = article.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

#Preview {
    let mockArticles = [
        Article(title: "Sample News 1", description: "Description for news 1", urlToImage: nil, url: "https://example.com"),
        Article(title: "Sample News 2", description: "Description for news 2", urlToImage: nil, url: "https://example.com")
    ]
    
    let mockNewsService = MockNewsService()
    let viewModel = NewsViewModel(newsService: mockNewsService)
    viewModel.articles = mockArticles
    return ArticleListView(viewModel: viewModel)
}

class MockNewsService: NewsServiceable {
    func fetchNews() async throws -> [Article] {
        return [
            Article(title: "Mock News 1", description: "Mock description 1", urlToImage: nil, url: "https://example.com"),
            Article(title: "Mock News 2", description: "Mock description 2", urlToImage: nil, url: "https://example.com")
        ]
    }
}
