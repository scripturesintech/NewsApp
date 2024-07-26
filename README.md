# News Reader App
A SwiftUI-based news reader app that fetches and displays the latest news articles using MVVM architecture and async/await for networking.

## Features
Fetch and display top news headlines.
Select and view detailed information about each news article.



https://github.com/user-attachments/assets/6b5a5347-16c9-48e8-b63d-94c48f26b834

![NewsList](https://github.com/user-attachments/assets/a2043b53-b803-4f9c-b645-af2420495ea0)
![NewsDetail](https://github.com/user-attachments/assets/6a74388c-86ae-410c-8cb7-d2069659cdf8)

## Architecture
This app follows the MVVM (Model-View-ViewModel) architecture pattern and employs SOLID principles to ensure code maintainability and scalability.

## SOLID Principles
- Single Responsibility Principle (SRP): Each class and struct has a single responsibility. For example, NetworkManager handles network requests, NewsService manages news fetching, and NewsViewModel processes and provides data to the views.

- Open/Closed Principle (OCP): The app is designed to be open for extension but closed for modification. For example, new news services or network configurations can be added without modifying existing code.

- Liskov Substitution Principle (LSP): The app ensures that objects of a superclass can be replaced with objects of a subclass without affecting the correctness of the program. This is managed by using protocols such as NewsServiceable and Networkable.

- Interface Segregation Principle (ISP): The app uses small, specific protocols rather than a large, general-purpose protocol. For example, Networkable and NewsServiceable protocols are designed to cover only the necessary methods.

- Dependency Inversion Principle (DIP): High-level modules (e.g., NewsViewModel) depend on abstractions (e.g., NewsServiceable), not on concrete implementations. This allows for easier testing and modification.

## Composition Root
The composition root is responsible for creating and injecting dependencies into the application. This setup ensures that components are configured and connected properly.

Example of Composition Root: Best example of Dependency injection
```
WindowGroup {
            let networkManager = NetworkManager()
            let newsService = NewsService(networkManager: networkManager)
            let viewModel = NewsViewModel(newsService: newsService)
            ArticleListView(viewModel: viewModel)
        }
```
