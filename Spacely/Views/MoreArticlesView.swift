//
//  MoreArticlesView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 22/10/2021.
//

import SwiftUI
import Kingfisher

struct MoreArticlesView: View {
    @ObservedObject var newsManager: NewsManager
    @Binding var showTapBar: Bool
    @Binding var showMoreArticlesView: Bool
    
    @State var numOfArticles = 30
    
    var body: some View {
        
        if newsManager.articlesArray.isNotEmpty{
            ZStack{
                VStack{
                    ScrollView {
                        ForEach(1..<newsManager.articlesArray.count-1, id: \.self){ index in
                            NavigationLink(destination: SummaryReadView(articleIndex: index, newsManager: newsManager, showTapBar: $showTapBar)) {
                                MoreNewsBubble(article: newsManager.articlesArray[index])
                            }
                        }
                        LoadMoreButton(newsManager: newsManager, numOfArticles: $numOfArticles)
                    }.padding(.bottom, 100)
                    
                    Spacer()
                }
                
                
                
                BackButtonFromMore(showMoreArticlesView: $showMoreArticlesView)
                
            }
        }
    }
}

struct MoreArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        MoreArticlesView(newsManager: NewsManager(), showTapBar: .constant(true), showMoreArticlesView: .constant(false))
    }
}

struct MoreNewsBubble: View {
    
    var article: ArticleModel
    
    var body: some View {
        HStack(spacing: 15){
            if let safeUrl = URL(string: article.imageURL){
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
                
                Text(article.title)
                    .foregroundColor(Color("ModeCorrection"))
                    .font(.system(size: 18, weight: .bold))
                    .padding(.bottom, 10)
                
                HStack{
                    Text(article.newsSite)
                        .foregroundColor(.gray)
                        .font(.system(size: 10, weight: .light))
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 10)
    }
}

struct LoadMoreButton: View {
    
    @ObservedObject var newsManager: NewsManager
    
    @Binding var numOfArticles: Int
    
    var body: some View {
        Button {
            numOfArticles = numOfArticles + 30
            newsManager.fetchNews(numberOfArticles: numOfArticles)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("BackgroundGray"))
                    .frame(height: 50)
                    .padding(.horizontal, 15)
                
                Text("Press to load more articles")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
        }
        
    }
}

struct BackButtonFromMore: View {
    
    @Binding var showMoreArticlesView: Bool
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    showMoreArticlesView = false
                } label: {
                    
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.blue)
                        .padding()
                        .background(Circle()
                                        .foregroundColor(.black))
                        .padding(.leading, 30)
                    
                    
                }
                Spacer()
            }
            .padding(.top, 30)
            Spacer()
        }
        
    }
}
