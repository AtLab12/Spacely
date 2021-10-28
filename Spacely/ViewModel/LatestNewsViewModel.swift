//
//  LatestNewsViewModel.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 20/10/2021.
//

import Foundation
import SwiftUI
import AVFoundation

class LatestNewsViewModel: NSObject, ObservableObject {
    
    @Published var isSpeaking = false
    
    let synthetizer = AVSpeechSynthesizer()
    
    override init() {
        super.init()
        self.synthetizer.delegate = self
    }
    
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
        
        synthetizer.speak(utterance)
        
        withAnimation {
            isSpeaking = true
        }
        
    }
    
    
}

extension LatestNewsViewModel: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        withAnimation {
            self.isSpeaking = false
        }
    }
}
