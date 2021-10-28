//
//  LoadingArticlesView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 28/10/2021.
//

import SwiftUI

struct LoadingArticlesView: View {
    var body: some View {
        Text("Loading articles ...")
            .font(.custom("Nunito-BlackItalic", size: 20))
            .foregroundColor(.gray)
    }
}

struct LoadingArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingArticlesView()
    }
}
