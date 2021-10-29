//
//  TopAlertView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 18/10/2021.
//

import SwiftUI

struct TopAlertView: View {
    
    var notification: String
    
    var body: some View {
        Text(notification)
            .foregroundColor(.black)
            .font(.custom("Nunito-Bold", size: 10))
            .padding(.vertical, 3)
            .padding(.horizontal, 5)
            .background(Capsule()
                            .foregroundColor(Color("BackgroundGray"))
                            .opacity(0.7))
            .padding(.trailing, 10)
    }
}

struct TopAlertView_Previews: PreviewProvider {
    static var previews: some View {
        TopAlertView(notification: "News up to date")
    }
}
