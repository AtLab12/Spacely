//
//  SummaryLikeButtonFunView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 29/10/2021.
//

import SwiftUI

struct SummaryLikeButtonFunView: View {
    
    var articleIndex: Int
    
    @ObservedObject var newsManager: NewsManager
    @ObservedObject var viewModel: LatestNewsViewModel
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Article.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Article.idNum, ascending: true)
    ]) var likedArticles: FetchedResults<Article>
    
    let buttonWidth:CGFloat = (UIScreen.main.bounds.width - 60)/3
    
    var body: some View {
        Button {
            if !viewModel.isSpeaking{
                if checkifArticleLiked() {
                    unlikeArticle()
                }   else {
                    let article = Article(context: managedObjectContext)
                    article.idNum = Int16(newsManager.articlesArray[articleIndex].id)
                    article.summary = newsManager.articlesArray[articleIndex].summary
                    article.sourceURL = newsManager.articlesArray[articleIndex].sourceURL
                    article.newsSite = newsManager.articlesArray[articleIndex].newsSite
                    article.title = newsManager.articlesArray[articleIndex].title
                    article.imageURL = newsManager.articlesArray[articleIndex].imageURL
                    do {
                        try managedObjectContext.save()
                    }   catch {
                        print(error)
                    }
                }
            }
        } label: {
            ZStack{
                Capsule()
                    .foregroundColor(Color("BackgroundGray"))
                    .frame(width: buttonWidth, height: 50)
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                Image(systemName: "heart.fill")
                    .font(.system(size: 20))
                    .foregroundColor(checkifArticleLiked() ? Color(#colorLiteral(red: 0.9149905443, green: 0.2920166254, blue: 0.4980185628, alpha: 0.8470588235)) : .gray)
            }
        }
        
    }
    
    fileprivate func unlikeArticle() {
        for article in likedArticles {
            if article.idNum == newsManager.articlesArray[articleIndex].id{
                managedObjectContext.delete(article)
                do {
                    try managedObjectContext.save()
                }   catch {
                    print(error)
                }
                return
            }
        }
    }
    
    fileprivate func checkifArticleLiked() -> Bool {
        
        for article in likedArticles {
            if article.idNum == newsManager.articlesArray[articleIndex].id{
                return true
            }
        }
        
        return false
    }
}

struct SummaryLikeButtonFunView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryLikeButtonFunView(articleIndex: 0, newsManager: NewsManager(), viewModel: LatestNewsViewModel())
    }
}
