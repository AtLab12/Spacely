//
//  NewsFeed.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 17/10/2021.
//

import SwiftUI

struct NewsFeed: View {
    
    @ObservedObject var newsManager: NewsManager
    @Binding var showMoreArticlesView: Bool
    @Binding var showTapBar: Bool
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Top news")
                    .font(.system(size: 30, weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
                
                MoreButtonView(newsManager: newsManager, showMoreArticlesView: $showMoreArticlesView)
            }
            
            if newsManager.articlesArray.count >= 2{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack{
                        ForEach(1..<20, id:\.self) { index in
                            if index < newsManager.articlesArray.count{
                                NavigationLink(destination: SummaryReadView(articleIndex: index, newsManager: newsManager, showTapBar: $showTapBar)) {
                                    NewsBubble(articleModel: newsManager.articlesArray[index])
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct NewsFeed_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeed(newsManager: NewsManager(), showMoreArticlesView: .constant(true), showTapBar: .constant(false))
    }
}
