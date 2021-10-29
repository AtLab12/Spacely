//
//  LatestNewsView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 18/10/2021.
//

import SwiftUI
import Kingfisher

struct LatestNewsView: View {
    
    @ObservedObject var newsManager: NewsManager
    @Binding var showTapBar: Bool
    
    let width = UIScreen.main.bounds.width
    
    @State var showNewsUpToDateNotification = false
    
    var body: some View {
        ZStack {
            
            if let safeUrl = URL(string: newsManager.articlesArray[0].imageURL) {
                KFImage(safeUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: 350)
                    .clipShape(RectCustomRound(corner: [.bottomLeft, .bottomRight], size: 35))
                    .ignoresSafeArea(.container, edges: .top)
            }
            
            
            if !newsManager.articlesArray.isEmpty{
                VStack(spacing: 20){
                    
                    HStack{
                        
                        Spacer()
                        
                        if showNewsUpToDateNotification {
                            TopAlertView(notification: "News up to date")
                        }
                        
                        RefreashButton(newsManager: newsManager, showNewsUpToDateNotification: $showNewsUpToDateNotification)
                            .padding(.trailing, 30)
                    }.padding(.bottom, 15)
                    
                    HStack {
                        ZStack {
                            Text("Latest news")
                                .foregroundColor(.black)
                                .font(.custom("Nunito-ExtraBold", size: 16))
                                .padding(.vertical, 5)
                                .padding(.horizontal, 7)
                                .background(Capsule()
                                                .foregroundColor(Color("BackgroundGray"))
                                                .opacity(0.7))
                        }.padding(.leading, 30)
                        
                        Spacer()
                    }
                    
                    HStack {
                        ZStack {
                            Text(newsManager.articlesArray[0].title)
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .bold))
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(Color("BackgroundGray"))
                                                .opacity(0.7))
                        }.padding(.leading, 30)
                        
                        Spacer()
                    }
                    
                    LearnModeButton(newsManager: newsManager, showTapBar: $showTapBar)
                }
                .padding(.bottom, 15)
                .padding(.top, 40)
            }
            
        }
    }
}

struct LatestNewsView_Previews: PreviewProvider {
    static var previews: some View {
        LatestNewsView(newsManager: NewsManager(), showTapBar: .constant(true))
    }
}

struct RectCustomRound: Shape {
    var corner: UIRectCorner
    var size: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: size, height: size))
        return Path(path.cgPath)
    }
}


struct LearnModeButton: View {
    
    @ObservedObject var newsManager: NewsManager
    @Binding var showTapBar: Bool
    
    var body: some View {
        
        NavigationLink(destination: SummaryReadView(articleIndex: 0, newsManager: newsManager, showTapBar: $showTapBar)) {
            HStack {
                Text("Learn more")
                    .foregroundColor(.white)
                    .font(.custom("Nunito-SemiBold", size: 14))
                    .padding(.leading, 30)
                    .padding(.trailing, 10)
                
                Image(systemName: "arrow.forward.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .scaledToFill()
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
    }
}
