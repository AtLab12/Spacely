//
//  MoreButtonView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 22/10/2021.
//

import SwiftUI

struct MoreButtonView: View {
    @ObservedObject var newsManager: NewsManager
    @Binding var showMoreArticlesView: Bool
    
    var body: some View {
        
        Button {
            showMoreArticlesView = true
        } label: {
            Text("more")
                .font(.system(size: 14, weight: .bold))
                .padding(.trailing, 30)
                .foregroundColor(Color("ModeCorrection"))
        }
    }
}

struct MoreButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MoreButtonView(newsManager: NewsManager(), showMoreArticlesView: .constant(true))
    }
}
