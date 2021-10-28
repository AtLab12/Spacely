//
//  HomeView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 18/10/2021.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var newsManager: NewsManager
    @Binding var showTapBar: Bool
    @State var showMoreArticlesView = false
    
    var body: some View {
        NavigationView{
            
            if !showMoreArticlesView{
                VStack {
                    LatestNewsView(newsManager: newsManager, showTapBar: $showTapBar)
                    NewsFeed(newsManager: newsManager, showMoreArticlesView: $showMoreArticlesView, showTapBar: $showTapBar)
                    Spacer()
                }
                .ignoresSafeArea(.container, edges: .top)
                .onAppear {
                    if newsManager.articlesArray.isEmpty{
                        newsManager.fetchNews(numberOfArticles: 30)
                    }
                    showTapBar = true
                }
                .navigationBarHidden(true)
            }   else {
                MoreArticlesView(newsManager: newsManager, showTapBar: $showTapBar, showMoreArticlesView: $showMoreArticlesView)
                    .navigationBarHidden(true)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(newsManager: NewsManager(), showTapBar: .constant(true))
    }
}
