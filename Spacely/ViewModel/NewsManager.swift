//
//  NewsManager.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 17/10/2021.
//

import Foundation

class NewsManager: ObservableObject {
    
    @Published var articlesArray = [ArticleModel]()
    
    let newsUrl = "https://api.spaceflightnewsapi.net/v3/articles?_limit="
    
    func fetchNews(numberOfArticles articlesNum: Int){
        let urlString = "\(newsUrl)\(articlesNum)"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        
        guard let url = URL(string: urlString) else {
            print("could not create url.")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil {
                print(error?.localizedDescription ?? "Error while fetching news")
                return
            }
            
            if let safeData = data {
                self.parseJSON(newsData: safeData)
            }
            
        }
        
        task.resume()
    }
    
    private func parseJSON(newsData data: Data){
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([NewsData].self, from: data)
            
            for news in decodedData{
                DispatchQueue.main.async {
                    if !self.articlesArray.contains(where: { $0.id == news.id }){ // wont add article if it is already there
                        
                        let newArticle = ArticleModel(id: news.id, title: news.title, sourceURL: news.url, imageURL: news.imageUrl, newsSite: news.newsSite, summary: news.summary)
                        
                        self.articlesArray.append(newArticle)
                        
                    }
                }
            }
        }   catch {
            print(error)
        }
    }
}
