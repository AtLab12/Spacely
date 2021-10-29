//
//  LanguagesChoiceRowView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 29/10/2021.
//

import SwiftUI

struct LanguagesChoiceRowView: View {
    @State var languageEnum: LanguageCodes
    @State var selected: Bool
    var body: some View {
        HStack {
            Text(languageEnum.getLanguageName())
                .font(.system(size: 17, weight: .semibold))
                .padding(.leading, 15)
            
            Spacer()
            if selected{
            Image(systemName: "checkmark")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.blue)
                .padding(.trailing, 15)
            }
        }.frame(height: 30)
    }
}

struct LanguagesChoiceRowView_Previews: PreviewProvider {
    static var previews: some View {
        LanguagesChoiceRowView(languageEnum: .polish, selected: true)
    }
}
