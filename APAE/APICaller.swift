import Foundation

final class APICaller {
    static let shared = APICaller()

    struct Constants {
        static let toHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=pt&apiKey=1d7225c5d26242dca298f42bbea8e1b8")
        
        static let searchUrlString = "https://newsapi.org/v2/everything?language=pt&sortedBy=popularity&apiKey=1d7225c5d26242dca298f42bbea8e1b8&q="
    }
    
    private init() {}
    
    public func getTopNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.toHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    
    
    
    public func search(with query: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        
        
        let urlString = Constants.searchUrlString + query
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

// Modules

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}

struct Source: Codable {
    let name: String
}
