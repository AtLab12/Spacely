//
//  LikeArticleSummaryLikeButtonFunView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 29/10/2021.
//

import SwiftUI

struct LikeArticleSummaryLikeButtonFunView: View {
    
    var article: FetchedResults<Article>.Element
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @FetchRequest(entity: Article.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Article.idNum, ascending: true)
    ]) var likedArticles: FetchedResults<Article>
    
    @Binding var showTapBar: Bool
    
    let buttonWidth:CGFloat = (UIScreen.main.bounds.width - 60)/3
    
    var body: some View {
        Button {
            unlikeArticle()
            showTapBar = true
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            ZStack{
                Capsule()
                    .foregroundColor(Color("BackgroundGray"))
                    .frame(width: buttonWidth, height: 50)
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                Image(systemName: "heart.fill")
                    .font(.system(size: 20))
                    .foregroundColor(Color(#colorLiteral(red: 0.9149905443, green: 0.2920166254, blue: 0.4980185628, alpha: 0.8470588235)))
            }
        }
        
    }
    
    fileprivate func unlikeArticle() {
        for article in likedArticles {
            if self.article.idNum == article.idNum{
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
}

