//
//  LikeArticleSummaryListenButtonFunView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 29/10/2021.
//

import SwiftUI

struct LikeArticleSummaryListenButtonFunView: View {
    
    var article: FetchedResults<Article>.Element
    
    let buttonWidth:CGFloat = (UIScreen.main.bounds.width - 60)/3
    
    @ObservedObject var viewModel: LatestNewsViewModel
    
    @Binding var selectedLanguage: LanguageCodes
    @Binding var text: (title: String, summary: String)
    
    var body: some View {
        Button {
            if !viewModel.isSpeaking{
                viewModel.read(message: text.summary == "" ? article.summary ?? "No summary available" : text.summary, languageCode: selectedLanguage.getLanguageCodeForSythethizer())
            }
        } label: {
            ZStack{
                Capsule()
                    .foregroundColor(Color("BackgroundGray"))
                    .frame(width: buttonWidth, height: 50)
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                if !viewModel.isSpeaking{
                Image(systemName: "speaker.wave.2")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                }   else {
                    EqualizerAnimation()
                        .frame(width: 30, height: 30)
                }
            }
        }
        
    }
}
