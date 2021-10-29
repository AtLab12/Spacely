//
//  SummaryListenButtonFunView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 29/10/2021.
//

import SwiftUI

struct SummaryListenButtonFunView: View {
    
    var articleIndex: Int
    
    @ObservedObject var newsManager: NewsManager
    
    let buttonWidth:CGFloat = (UIScreen.main.bounds.width - 60)/3
    
    @StateObject var viewModel = LatestNewsViewModel()
    
    @Binding var selectedLanguage: LanguageCodes
    @Binding var text: (title: String, summary: String)
    
    var body: some View {
        Button {
            viewModel.read(message: text.summary == "" ? newsManager.articlesArray[articleIndex].summary : text.summary, languageCode: selectedLanguage.getLanguageCodeForSythethizer())
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

struct SummaryListenButtonFunView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryListenButtonFunView(articleIndex: 0, newsManager: NewsManager(), selectedLanguage: .constant(.englishUS), text: .constant(("","")))
    }
}
