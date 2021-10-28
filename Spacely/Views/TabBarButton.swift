//
//  TabBarButton.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 18/10/2021.
//

import SwiftUI

struct TabBarButton: View {
    
    var imageName: String
    @Binding var selectedTabName: String
    
    var body: some View {
        GeometryReader{ reader in
            Button {
                withAnimation {
                    selectedTabName = imageName
                }
            } label: {
                Image(systemName: imageName)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .offset(y: selectedTabName == imageName ? -10 : 0)
            }

            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.frame(height: 35)
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButton(imageName: "house.fill", selectedTabName: .constant("house.fill"))
    }
}
