//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Roopesh Tripathi on 25/07/24.
//
//
import SwiftUI

struct ArticleDetailView: View {
    let article: Article

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.title)
                    .padding(.bottom, 8)

                if let description = article.description {
                    Text(description)
                        .font(.body)
                        .padding(.bottom, 16)
                }

                if let urlToImage = article.urlToImage, let imageUrl = URL(string: urlToImage) {
                    AsyncImage(url: imageUrl) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                        case .failure:
                            Image(systemName: "photo.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(height: 200)
                    .clipped()
                }

                if let url = URL(string: article.url) {
                    Link("Read Full Article", destination: url)
                        .padding(.top, 16)
                }
            }
            .padding()
        }
        .navigationTitle("Article Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let mockArticle = Article(
        title: "Mock Article Title",
        description: "This is a detailed description of the mock article.",
        urlToImage: "https://picsum.photos/200",
        url: "https://example.com"
    )
    
    return NavigationView {
        ArticleDetailView(article: mockArticle)
    }
}
