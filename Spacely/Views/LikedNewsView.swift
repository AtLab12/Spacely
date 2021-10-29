//
//  LikedNewsView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 18/10/2021.
//

import SwiftUI
import Kingfisher

struct LikedNewsView: View {
    
    @Binding var showTapBar: Bool
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Article.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Article.idNum, ascending: true)
    ]) var likedArticles: FetchedResults<Article>
    
    var body: some View {
        
        if likedArticles.isNotEmpty{
            NavigationView{
                List {
                    ForEach(likedArticles, id: \.self){ article in
                        NavigationLink(destination: LikedSummaryReadView(showTapBar: $showTapBar, article: article)) {
                            LikedListBubble(article: article)
                        }
                    }
                }
                .navigationBarHidden(true)
            }
        }   else {
            VStack(spacing: 20){
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 150))
                    .foregroundColor(Color("ModeCorrection"))
                    .onAppear {
                        showTapBar = true
                    }
                
                Text("No liked articles found.")
                    .font(.custom("Nunito-ExtraBold", size: 20))
                    .foregroundColor(Color("ModeCorrection"))
            }
        }
    }
}

struct LikedNewsView_Previews: PreviewProvider {
    static var previews: some View {
        LikedNewsView(showTapBar: .constant(true))
    }
}

struct LikedListBubble: View {
    
    var article: FetchedResults<Article>.Element
    
    var body: some View{
        HStack(spacing: 15){
            if let safeUrl = URL(string: article.imageURL ?? ""){
                KFImage(safeUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }   else {
                Image("RocketLaunch3")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            VStack{
                
                Text(article.title ?? "No title")
                    .foregroundColor(Color("ModeCorrection"))
                    .font(.custom("Nunito-ExtraBoldItalic", size: 18))
                    .padding(.bottom, 10)
                
                HStack{
                    Text("by \(article.newsSite ?? "Uknown source")")
                        .foregroundColor(.gray)
                        .font(.custom("Nunito-Light", size: 10))
                    
                    Spacer()
                }
            }
        }
    }
}
