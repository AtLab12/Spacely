//
//  LaunchScreenAnimation.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 28/10/2021.
//

import SwiftUI
import SpriteKit
import AVKit
import PureSwiftUI

struct LaunchScreenAnimation: View {
    
    var halfScreenSize = UIScreen.main.bounds.height
    @Binding var showLaunchScrene: Bool
    @State var rocketGoesWraWra = false
    @State var audioPlayer: AVAudioPlayer!
    
    var body: some View {
        ZStack{
            Color.black
            
            VStack{
                Text("spacely")
                    .font(.system(size: 55))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            VStack{
            Image("RocketImage")
                .renderingMode(.template)
                .resizable()
                .foregroundColor(.white)
                .frame(width: 80, height: 85)
                .offset(y: rocketGoesWraWra ? -(halfScreenSize+45) : halfScreenSize+45)
                .onAppear {
                    withAnimation(Animation.linear(duration: 4)) {
                        rocketGoesWraWra = true
                    }
                    let soundEffect = Bundle.main.path(forResource: "RocketLaunch", ofType: "wav")
                    self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundEffect!))
                    self.audioPlayer.play()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                        self.audioPlayer.stop()
                    }
                    
                }
                Spacer()
            }
            
            SpriteView(scene: RocketSmoke(), options: [.allowsTransparency])
                .offset(y: rocketGoesWraWra ? -(halfScreenSize+45) : halfScreenSize+45)
                .onAppear {
                    withAnimation(Animation.linear(duration: 4)) {
                        rocketGoesWraWra = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        withAnimation {
                            showLaunchScrene = false
                        }
                    }
                }
            
        }.ignoresSafeArea()
    }
}


class RocketSmoke: SKScene {
    
    override func sceneDidLoad() {
        
        size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*2)
        scaleMode = .resizeFill
        
        anchorPoint = CGPoint(x: 0.5, y: 0.90)
        
        backgroundColor = .clear
        
        let node = SKEmitterNode(fileNamed: "Smoke.sks")!
        addChild(node)
    }
}

struct LaunchScreenAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenAnimation(showLaunchScrene: .constant(true))
    }
}
