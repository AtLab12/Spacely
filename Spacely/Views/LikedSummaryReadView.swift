//
//  LikedSummaryReadView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 21/10/2021.
//

import SwiftUI
import Kingfisher

struct LikedSummaryReadView: View {
    
    @Binding var showTapBar: Bool
    
    @State var presentWebArticleSheet = false
    
    var article: FetchedResults<Article>.Element
    
    var body: some View {
        
        ZStack{
            if let safeUrl = URL(string: article.imageURL ?? ""){
                ZStack {
                    VStack {
                        
                        KFImage(safeUrl)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: 450)
                            .ignoresSafeArea(.container, edges: .top)
                        
                        
                        Spacer()
                    }
                    
                    VStack {
                        HStack {
                            LikeArticleCustomBackButton(showTapBar: $showTapBar)
                                .padding(.top, 10)
                                .padding(.leading, 30)
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
            
            VStack {
                Spacer()
                ZStack {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width)
                        .clipShape(RectCustomRound(corner: [.topLeft, .topRight], size: 35))
                        .foregroundColor(.white)
                        .ignoresSafeArea()
                    
                    VStack{
                        HStack {
                            Text(article.title ?? "No title")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.leading, 20)
                                .padding(.top, 20)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        
                        HStack {
                            Text(article.summary ?? "No summary available")
                                .font(.system(size: 15, weight:.semibold))
                                .lineLimit(15)
                                .padding(.top, 10)
                                .padding(.leading, 20)
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("by \(article.newsSite ?? "Uknown source")")
                                .font(.system(size: 10, weight:.semibold))
                                .foregroundColor(.gray)
                                .lineLimit(1)
                                .padding(.top, 10)
                                .padding(.leading, 20)
                            
                            Spacer()
                        }
                        
                        HStack(spacing: 10){
                            LikeArticleSummaryListenButtonFunView(article: article)
                            
                            LikeArticleSummaryLikeButtonFunView(article: article, showTapBar: $showTapBar)
                        }.padding(.horizontal, 20)
                        
                        LikeArticleReadFullArticleButtonView(presentWebArticleSheet: $presentWebArticleSheet)
                        
                        Spacer()
                        
                    }.padding(.top, 15)
                }.padding(.top, 250)
            }
        }
        .onAppear {
            showTapBar = false
        }
        .sheet(isPresented: $presentWebArticleSheet, onDismiss: {
            presentWebArticleSheet = false
        }, content: {
            if let safeUrl = URL(string: article.sourceURL ?? ""){
                ArticleWebView(model: WebViewModel(url: safeUrl), presentWebArticleSheet: $presentWebArticleSheet)
            }   else {
                Text("Incorrect url")
            }
        })
        .navigationBarHidden(true)
    }
}

struct LikedSummaryReadView_Previews: PreviewProvider {
    static var previews: some View {
        LikedNewsView(showTapBar: .constant(true))
    }
}

struct LikeArticleCustomBackButton: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var showTapBar: Bool
    
    var body: some View {
        
        Button {
            showTapBar = true
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "arrowshape.turn.up.backward.fill")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.blue)
                .padding()
                .background(Circle()
                                .foregroundColor(.black))
        }
        
    }
}

struct LikeArticleSummaryListenButtonFunView: View {
    
    var article: FetchedResults<Article>.Element
    
    let buttonWidth:CGFloat = (UIScreen.main.bounds.width - 60)/2
    
    var viewModel = LatestNewsViewModel()
    
    var body: some View {
        Button {
            viewModel.read(message: article.summary ?? "No summary available", languageCode: "en-US")
        } label: {
            ZStack{
                Capsule()
                    .foregroundColor(Color("BackgroundGray"))
                    .frame(width: buttonWidth, height: 50)
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                Image(systemName: "speaker.wave.2")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
            }
        }
        
    }
}

struct LikeArticleSummaryLikeButtonFunView: View {
    
    var article: FetchedResults<Article>.Element
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @FetchRequest(entity: Article.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Article.idNum, ascending: true)
    ]) var likedArticles: FetchedResults<Article>
    
    @Binding var showTapBar: Bool
    
    let buttonWidth:CGFloat = (UIScreen.main.bounds.width - 60)/2
    
    var body: some View {
        Button {
            unlikeArticle()
            showTapBar = true
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            ZStack{
                Capsule()
                    .foregroundColor(Color("BackgroundGray"))
                    .frame(width: buttonWidth, height: 50)
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                Image(systemName: "heart.fill")
                    .font(.system(size: 20))
                    .foregroundColor(Color(#colorLiteral(red: 0.9149905443, green: 0.2920166254, blue: 0.4980185628, alpha: 0.8470588235)))
            }
        }
        
    }
    
    fileprivate func unlikeArticle() {
        for article in likedArticles {
            if self.article.idNum == article.idNum{
                managedObjectContext.delete(article)
                do {
                    try managedObjectContext.save()
                }   catch {
                    print(error)
                }
                return
            }
        }
    }
}

struct LikeArticleReadFullArticleButtonView: View {
    
    @Binding var presentWebArticleSheet: Bool
    
    var body: some View {
        Button {
            presentWebArticleSheet = true
        } label: {
            ZStack {
                Capsule()
                    .foregroundColor(Color("BackgroundGray"))
                    .frame( height: 50)
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                Text("Read full article")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.gray)
            }.padding(.horizontal, 20)
        }.padding(.top, 15)
    }
}
