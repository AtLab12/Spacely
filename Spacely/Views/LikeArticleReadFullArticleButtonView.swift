//
//  LikeArticleReadFullArticleButtonView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 29/10/2021.
//

import SwiftUI

struct LikeArticleReadFullArticleButtonView: View {
    
    @Binding var presentWebArticleSheet: Bool
    
    var body: some View {
        Button {
            presentWebArticleSheet = true
        } label: {
            ZStack {
                Capsule()
                    .foregroundColor(Color("BackgroundGray"))
                    .frame( height: 50)
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                Text("Read full article")
                    .font(.custom("Nunito-Bold", size: 14))
                    .foregroundColor(.gray)
            }.padding(.horizontal, 20)
        }.padding(.top, 15)
    }
}

struct LikeArticleReadFullArticleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LikeArticleReadFullArticleButtonView(presentWebArticleSheet: .constant(false))
    }
}
