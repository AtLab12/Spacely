//
//  LatestNewsViewModel.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 20/10/2021.
//

import Foundation
import AVFoundation

struct LatestNewsViewModel {
    func read(message text: String, languageCode: String){
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: languageCode)
        utterance.rate = 0.5
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
            
        } catch {
            print(error.localizedDescription)
        }
        
        let synthetizer = AVSpeechSynthesizer()
        
        synthetizer.speak(utterance)
        
    }
}
