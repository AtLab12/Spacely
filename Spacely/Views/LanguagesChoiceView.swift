//
//  LanguagesChoiceView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 29/10/2021.
//

import SwiftUI

struct LanguagesChoiceView: View {
    
    var viewModel = LanguageChoiceViewModel()
    
    @Binding var selectedLanguage: LanguageCodes
    @Binding var text: (title: String, summary: String)
    @Binding var showLanguageChoiceView: Bool
    
    var title: String
    var summary: String
    
    var body: some View {
        ScrollView{
            ForEach(viewModel.getLanguageChoiceEnumsInArray()) { languageSubStruct in
                
                LanguagesChoiceRowView(languageEnum: languageSubStruct.languageCode, selected: selectedLanguage.getLanguageName() == languageSubStruct.languageCode.getLanguageName() ? true : false)
                
                    .onTapGesture {
                        selectedLanguage = languageSubStruct.languageCode
                        
                        if selectedLanguage == .englishUS{
                            text.title = title
                            text.summary = summary
                        }   else {
                            
                            TranslationManager.shared.translate(message: title, toLanguage: selectedLanguage.getLanguageTranslationCode() , fromLanguage: "en") { translatedText in
                                
                                if let safeTranslatedTitle = translatedText {
                                    TranslationManager.shared.translate(message: summary, toLanguage: selectedLanguage.getLanguageTranslationCode(), fromLanguage: "en") { translatedSummary in
                                        if let safeTranslatedSummary = translatedSummary {
                                            print(safeTranslatedTitle)
                                            print(safeTranslatedSummary)
                                            withAnimation {
                                                text.title = safeTranslatedTitle
                                                text.summary = safeTranslatedSummary
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        withAnimation(Animation.easeOut(duration: 0.3)) {
                            showLanguageChoiceView = false
                        }
                    }
            }
        }.padding()
            .frame(width: 200)
            .background(RoundedRectangle(15)
                            .foregroundColor(.gray))
    }
}

struct LanguagesChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        LanguagesChoiceView(selectedLanguage: .constant(LanguageCodes.englishUS), text: .constant(("","")), showLanguageChoiceView: .constant(false), title: "", summary: "")
    }
}
