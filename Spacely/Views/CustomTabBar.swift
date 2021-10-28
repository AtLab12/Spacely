//
//  CustomTabBar.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 18/10/2021.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedTabName: String
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            TabBarButton(imageName: "house.fill", selectedTabName: $selectedTabName)
            
            TabBarButton(imageName: "heart.text.square.fill", selectedTabName: $selectedTabName)
            
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(40)
        .padding(.horizontal, 80)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTabName: .constant("house.fill"))
    }
}
