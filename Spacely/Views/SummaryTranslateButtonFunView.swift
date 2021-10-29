//
//  SummaryTranslateButtonFunView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 29/10/2021.
//

import SwiftUI

struct SummaryTranslateButtonFunView: View {
    
    let buttonWidth:CGFloat = (UIScreen.main.bounds.width - 60)/3
    
    @Binding var showChooseLanguageView: Bool
    @ObservedObject var viewModel: LatestNewsViewModel
    var body: some View {
        Button {
            if !viewModel.isSpeaking{
                withAnimation {
                    showChooseLanguageView = true
                }
            }
        } label: {
            ZStack{
                Capsule()
                    .foregroundColor(Color("BackgroundGray"))
                    .frame(width: buttonWidth, height: 50)
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                Image("TranslationIcon")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .scaledToFill()
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
            }
        }
        
    }
}

struct SummaryTranslateButtonFunView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryTranslateButtonFunView(showChooseLanguageView: .constant(false), viewModel: LatestNewsViewModel())
    }
}
