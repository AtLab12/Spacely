//
//  ArticleWebView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 19/10/2021.
//

import SwiftUI

struct ArticleWebView: View {
    
    @StateObject var model: WebViewModel
    @Binding var presentWebArticleSheet: Bool
    
    var body: some View {
        ZStack{
            WebView(webView: model.webView)
            
            VStack{
                HStack{
                    Spacer()
                    Button {
                        withAnimation {
                            presentWebArticleSheet = false
                        }
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.black)
                                .opacity(0.2)
                            
                            Image(systemName: "multiply")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.blue)
                        }
                    }.padding(.trailing, 20)

                }.padding(.top, 20)
                Spacer()
            }
        }
    }
}

struct ArticleWebView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleWebView(model: WebViewModel(url: URL(string: "")!), presentWebArticleSheet: .constant(true))
    }
}
