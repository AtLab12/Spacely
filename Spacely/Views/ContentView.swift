//
//  ContentView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 17/10/2021.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @StateObject var newsViewModel = NewsManager()
    
    @State var viewName = "house.fill"
    @State var showTabBar = true
    
    var body: some View {
        
        ZStack{
            switch viewName{
            case "house.fill":
                HomeView(newsManager: newsViewModel, showTapBar: $showTabBar)
            case "heart.text.square.fill":
                LikedNewsView(showTapBar: $showTabBar)
            default:
                HomeView(newsManager: newsViewModel, showTapBar: $showTabBar)
            }
            
            if showTabBar{
            VStack{
                Spacer()
                
                CustomTabBar(selectedTabName: $viewName)
            }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
