//
//  LanguageCodes.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 29/10/2021.
//

import Foundation

enum LanguageCodes: CaseIterable{
    
    case arabic
    case chineseChina
    case czech
    case danish
    case dutchNetherlands
    case englishUS
    case finnish
    case frenchFrance
    case german
    case greek
    case hebrew
    case hindi
    case hungarian
    case indonesian
    case italian
    case japanese
    case korean
    case norwegian
    case polish
    case portugesePortugal
    case romanian
    case russian
    case slovak
    case spanishSpain
    case swedish
    case thai
    case turkish
    
    func getLanguageCodeForSythethizer() -> String { // language code BGC47
        switch self {
            
        case .arabic:
            return "ar-SA"
        case .chineseChina:
            return "zh-CN"
        case .czech:
            return "cs-CZ"
        case .danish:
            return "da-DK"
        case .dutchNetherlands:
            return "nl-NL"
        case .englishUS:
            return "en-US"
        case .finnish:
            return "fi-FI"
        case .frenchFrance:
            return "fr-FR"
        case .german:
            return "de-DE"
        case .greek:
            return "el-GR"
        case .hebrew:
            return "he-IL"
        case .hindi:
            return "hi-IN"
        case .hungarian:
            return "hu-HU"
        case .indonesian:
            return "id-ID"
        case .italian:
            return "it-IT"
        case .japanese:
            return "ja-JP"
        case .korean:
            return "ko-KR"
        case .norwegian:
            return "no-NO"
        case .polish:
            return "pl-PL"
        case .portugesePortugal:
            return "pt-PT"
        case .romanian:
            return "ro-RO"
        case .russian:
            return "ru-RU"
        case .slovak:
            return "sk-SK"
        case .spanishSpain:
            return "es-ES"
        case .swedish:
            return "sv-SE"
        case .thai:
            return "th-TH"
        case .turkish:
            return "tr-TR"
        }
    }
    
    func getLanguageName() -> String {
        switch self {
            
        case .arabic:
            return "Arabic"
        case .chineseChina:
            return "Chinese Sim."
        case .czech:
            return "Czech"
        case .danish:
            return "Danish"
        case .dutchNetherlands:
            return "Dutch"
        case .englishUS:
            return "English"
        case .finnish:
            return "Finnish"
        case .frenchFrance:
            return "French"
        case .german:
            return "German"
        case .greek:
            return "Greek"
        case .hebrew:
            return "Hebrew"
        case .hindi:
            return "Hindi"
        case .hungarian:
            return "Hungarian"
        case .indonesian:
            return "Indonesian"
        case .italian:
            return "Italina"
        case .japanese:
            return "Japanese"
        case .korean:
            return "Korean"
        case .norwegian:
            return "Norwegian"
        case .polish:
            return "Polish"
        case .portugesePortugal:
            return "Portugese"
        case .romanian:
            return "Romanian"
        case .russian:
            return "Russian"
        case .slovak:
            return "Slovak"
        case .spanishSpain:
            return "Spanish"
        case .swedish:
            return "Swedish"
        case .thai:
            return "Thai"
        case .turkish:
            return "Turkish"
        }
    }
    
    
    func getLanguageTranslationCode() -> String {
        switch self {
            
        case .arabic:
            return "ar"
        case .chineseChina:
            return "zh-CN"
        case .czech:
            return "cs"
        case .danish:
            return "da"
        case .dutchNetherlands:
            return "nl"
        case .englishUS:
            return "en"
        case .finnish:
            return "fi"
        case .frenchFrance:
            return "fr"
        case .german:
            return "de"
        case .greek:
            return "el"
        case .hebrew:
            return "iw"
        case .hindi:
            return "hi"
        case .hungarian:
            return "hu"
        case .indonesian:
            return "id"
        case .italian:
            return "it"
        case .japanese:
            return "ja"
        case .korean:
            return "ko"
        case .norwegian:
            return "no"
        case .polish:
            return "pl"
        case .portugesePortugal:
            return "pt"
        case .romanian:
            return "ro"
        case .russian:
            return "ru"
        case .slovak:
            return "sk"
        case .spanishSpain:
            return "es"
        case .swedish:
            return "sv"
        case .thai:
            return "th"
        case .turkish:
            return "tr"
        }
    }
}

/*
 
 Arabic (Saudi Arabia) - ar-SA
 Chinese (China) - zh-CN
 Chinese (Hong Kong SAR China) - zh-HK
 Chinese (Taiwan) - zh-TW
 Czech (Czech Republic) - cs-CZ
 Danish (Denmark) - da-DK
 Dutch (Belgium) - nl-BE
 Dutch (Netherlands) - nl-NL
 English (Australia) - en-AU
 English (Ireland) - en-IE
 English (South Africa) - en-ZA
 English (United Kingdom) - en-GB
 English (United States) - en-US
 Finnish (Finland) - fi-FI
 French (Canada) - fr-CA
 French (France) - fr-FR
 German (Germany) - de-DE
 Greek (Greece) - el-GR
 Hebrew (Israel) - he-IL
 Hindi (India) - hi-IN
 Hungarian (Hungary) - hu-HU
 Indonesian (Indonesia) - id-ID
 Synthetizer supported lnguages
 Italian (Italy) - it-IT
 Japanese (Japan) - ja-JP
 Korean (South Korea) - ko-KR
 Norwegian (Norway) - no-NO
 Polish (Poland) - pl-PL
 Portuguese (Brazil) - pt-BR
 Portuguese (Portugal) - pt-PT
 Romanian (Romania) - ro-RO
 Russian (Russia) - ru-RU
 Slovak (Slovakia) - sk-SK
 Spanish (Mexico) - es-MX
 Spanish (Spain) - es-ES
 Swedish (Sweden) - sv-SE
 Thai (Thailand) - th-TH
 Turkish (Turkey) - tr-TR
*/

