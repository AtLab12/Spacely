//
//  TranslationManager.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 29/10/2021.
//

import Foundation

class TranslationManager: NSObject {
    
    static let shared = TranslationManager()
    
    private let apiKey = "AIzaSyAB1XsvwoBirLRo8zKiYhzWU9slMtXkOLo"
    
    var textToTranslate: String?
    
    var targetLanguageCode: String?
    
    override init(){
        super.init()
    }
    
    private func makeRequest(urlParams: [String: String], completion: @escaping (_ results: [String: Any]?) -> Void) {
    
        
        if var components = URLComponents(string: "https://translation.googleapis.com/language/translate/v2") {
            components.queryItems = [URLQueryItem]()
            
            for (key, value) in urlParams {
                components.queryItems?.append(URLQueryItem(name: key, value: value))
            }
            
            if let url = components.url {
                var request = URLRequest(url: url)
                
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
                
                let session = URLSession(configuration: .default)
                print(url)
                let task = session.dataTask(with: request) { (results,response,error) in
                    
                    if let error = error {
                        print(error)
                        completion(nil)
                    }
                    
                    if let response = response as? HTTPURLResponse, let results = results {
                        
                        if response.statusCode == 200 || response.statusCode == 201 {
                            do {
                                if let resultDict = try JSONSerialization.jsonObject(with: results, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String: Any]{
                                    completion(resultDict)
                                    print("request successfull")
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                        }   else {
                            print("Problem with response code \(response.statusCode)")
                        }
                    }   else {
                        
                        completion(nil)
                    }
                }
                
                task.resume()
            }
        }
    }
    
    func translate(message textToTranslate: String?, toLanguage targetLanguageCode: String?, fromLanguage sourceLanguageCode: String?, completion: @escaping (_ translations: String?) -> Void) {
        guard let safeTextToTranslate = textToTranslate, let safeTargetLanguageCode = targetLanguageCode, let safeSourceLanguageCode = sourceLanguageCode else {
            completion(nil)
            return
        }
        
        var urlParams = [String: String]() // setting parameters for url request
        urlParams["key"] = apiKey
        urlParams["q"] = safeTextToTranslate
        urlParams["target"] = safeTargetLanguageCode
        urlParams["format"] = "text"
        urlParams["source"] = safeSourceLanguageCode
        
        print("about to make request")
        
        makeRequest(urlParams: urlParams) { results in
            guard let results = results else {
                completion(nil)
                return
            }
            
            if let data = results["data"] as? [String: Any], let translations = data["translations"] as? [[String : Any]] {
                var allTranslations = [String]()
                for translation in translations {
                    if let translatedText = translation["translatedText"] as? String { // getting value of translation to arrray
                        allTranslations.append(translatedText)
                    }
                }
                
                if allTranslations.count > 0 {
                    completion(allTranslations[0])  // return first translation
                 }   else {
                    completion(nil)
                }
            }   else {
                completion(nil)
            }

        }
    }
}
