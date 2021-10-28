//
//  RefreashButton.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 18/10/2021.
//

import SwiftUI
import PureSwiftUI

struct RefreashButton: View {
    
    @ObservedObject var newsManager: NewsManager
    
    @Binding var showNewsUpToDateNotification: Bool
    
    var body: some View {
        Button {
            newsManager.fetchNews(numberOfArticles: 15)
            withAnimation {
                showNewsUpToDateNotification = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                withAnimation {
                    showNewsUpToDateNotification = false
                }
            })
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.black)
                
                Image(systemName: "arrow.triangle.2.circlepath")
                    .font(.system(size: 25))
                    .foregroundColor(.blue)
                    .rotateIf(showNewsUpToDateNotification, 360.degrees)
            }
        }

    }
}

struct RefreashButton_Previews: PreviewProvider {
    static var previews: some View {
        RefreashButton(newsManager: NewsManager(), showNewsUpToDateNotification: .constant(true))
    }
}
