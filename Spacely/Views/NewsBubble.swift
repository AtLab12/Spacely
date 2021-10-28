//
//  NewsBubble.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 17/10/2021.
//

import SwiftUI
import Kingfisher

struct NewsBubble: View {
    
    var articleModel: ArticleModel
    
    var body: some View {
        

            
            VStack{
                if let safeURl = URL(string: articleModel.imageURL){
                    KFImage(safeURl)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                }   else {
                    Image("RocketLaunch1")
                        .resizable()
                        .frame(width: 200, height: 140)
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                    
                    
                HStack{
                    Text(articleModel.title)
                            .font(.custom("RNSSanz-Bold", size: 13))
                            .foregroundColor(Color("ModeCorrection"))
                            .frame(height: 70)
                            .multilineTextAlignment(.leading)
                    Spacer()
                }.frame(width: 200)
                
                Text("by \(articleModel.newsSite)")
                    .foregroundColor(.gray)
                    .font(.system(size: 9, weight: .light))
                    .padding(.top, 5)
            }.padding(.leading, 20)
    }
}

struct NewsBubble_Previews: PreviewProvider {
    static var previews: some View {
        NewsBubble(articleModel: ArticleModel(id: 2, title: "Rocket goes to space and returns whaaat", sourceURL: "", imageURL: "", newsSite: "", summary: ""))
    }
}
