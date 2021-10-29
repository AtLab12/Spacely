//
//  LanguageChoiceViewModel.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 29/10/2021.
//

import Foundation

struct LanguageChoiceViewModel {
    
    func getLanguageChoiceEnumsInArray() -> [LanguageCodeSubStruct]{
        var returnArray:[LanguageCodeSubStruct] = []
     
        for language in LanguageCodes.allCases {
            returnArray.append(LanguageCodeSubStruct(languageCode: language))
        }
        
        return returnArray
    }
}

struct LanguageCodeSubStruct: Identifiable {
    let id = UUID()
    var languageCode: LanguageCodes
}
