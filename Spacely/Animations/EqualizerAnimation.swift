//
//  EqualizerAnimation.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 28/10/2021.
//

import SwiftUI
import PureSwiftUI

private let numBars = 5
private let spacerWidthRatio: CGFloat = 0.2
private let barWidthScaleFactor = 1 / (numBars.asCGFloat + (numBars - 1).asCGFloat * spacerWidthRatio)

struct EqualizerAnimation: View {
    
    @State var animating = false
    
    var body: some View {
        GeometryReader { (geo: GeometryProxy) in
            let barWidth = geo.widthScaled(barWidthScaleFactor)
            let spacerWidth = barWidth * spacerWidthRatio
            
            HStack (spacing: spacerWidth) {
                ForEach(0..<numBars) { index in
                    
                    
                        Bar(minHeightFraction: 0.1, maxHeightFraction: 1, completion: animating ? 1 : 0)
                        .fillColor(.blue)
                            .width(barWidth)
                            .animation(createAnimation())
                        
                    
                }
            }
            
        }
        
        .onAppear {
            animating = true
        }
    }
    
    private func createAnimation() -> Animation {
        Animation
            .easeInOut(duration: 0.8 + Double.random(in: -0.3...0.3))
            .repeatForever(autoreverses: true)
            .delay(Double.random(in: 0...0.75))
    }
}

private struct Bar: Shape {
    
    private let minHeightFraction: CGFloat
    private let maxHeightFraction: CGFloat
    var animatableData: CGFloat
    
    init(minHeightFraction: CGFloat, maxHeightFraction: CGFloat, completion: CGFloat){
        self.minHeightFraction = minHeightFraction
        self.maxHeightFraction = maxHeightFraction
        self.animatableData = completion
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let heightFraction = minHeightFraction.to(maxHeightFraction, animatableData)
        
        path.roundedRect(rect.scaled(.size(1, heightFraction), at: rect.center, anchor: .center), cornerSize: CGSize(20, 20))
        
        return path
    }
}

struct EqualizerAnimation_Previews: PreviewProvider {
    static var previews: some View {
        EqualizerAnimation()
    }
}
