//
//  NewsService.swift
//  NewsApp
//
//  Created by Roopesh Tripathi on 25/07/24.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .requestFailed:
            return "The network request failed. Please try again later."
        case .invalidResponse:
            return "The response from the server was invalid."
        case .decodingError:
            return "Failed to decode the response from the server."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}

protocol NewsServiceable {
    func fetchNews() async throws -> [Article]
}

protocol Networkable {
    func fetchData(from url: URL) async throws -> Data
}

actor NetworkManager: Networkable {
    func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.requestFailed
        }
        return data
    }
}

class NewsService: NewsServiceable {
    private let networkManager: Networkable
    private let apiKey = "fb89621770df496dbdd3eef3513fb1f7"
    private let baseURL = "https://newsapi.org/v2/top-headlines"

    init(networkManager: Networkable) {
        self.networkManager = networkManager
    }
}

extension NewsService {
    
    func fetchNews() async throws -> [Article] {
        guard let url = URL(string: "\(baseURL)?country=in&apiKey=\(apiKey)") else {
            throw NetworkError.invalidURL
        }
        debugPrint("Request URL: \(url)")
        let data = try await networkManager.fetchData(from: url)
        
        do {
            let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
            debugPrint("Decoded Response: \(newsResponse)")
            return newsResponse.articles
        } catch {
            debugPrint("Decoding Error: \(error)")
            throw NetworkError.decodingError
        }
    }
}
