//
//  SummaryReadView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 17/10/2021.
//

import SwiftUI
import Kingfisher

struct SummaryReadView: View {
    
    var articleIndex: Int
    
    @ObservedObject var newsManager: NewsManager
    
    @Binding var showTapBar: Bool
    
    @State var presentWebArticleSheet = false
    
    var body: some View {
        
        ZStack{
            if let safeUrl = URL(string: newsManager.articlesArray[articleIndex].imageURL){
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
                            CustomBackButton(showTapBar: $showTapBar)
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
                            Text(newsManager.articlesArray[articleIndex].title)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.leading, 20)
                                .padding(.top, 20)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        
                        HStack {
                            Text(newsManager.articlesArray[articleIndex].summary)
                                .font(.system(size: 15, weight:.semibold))
                                .lineLimit(15)
                                .padding(.top, 10)
                                .padding(.leading, 20)
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("by \(newsManager.articlesArray[articleIndex].newsSite)")
                                .font(.system(size: 10, weight:.semibold))
                                .foregroundColor(.gray)
                                .lineLimit(1)
                                .padding(.top, 10)
                                .padding(.leading, 20)
                            
                            Spacer()
                        }
                        
                        HStack(spacing: 10){
                            SummaryListenButtonFunView(articleIndex: articleIndex, newsManager: newsManager)
                            
                            SummaryLikeButtonFunView(articleIndex: articleIndex, newsManager: newsManager)
                        }.padding(.horizontal, 20)
                        
                        ReadFullArticleButtonView(presentWebArticleSheet: $presentWebArticleSheet)
                        
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
            if let safeUrl = URL(string: newsManager.articlesArray[articleIndex].sourceURL){
                ArticleWebView(model: WebViewModel(url: safeUrl), presentWebArticleSheet: $presentWebArticleSheet)
            }   else {
                Text("Incorrect url")
            }
        })
        .navigationBarHidden(true)
    }
}

struct SummaryReadView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryReadView(articleIndex: 3, newsManager: NewsManager(), showTapBar: .constant(false))
    }
}

struct CustomBackButton: View {
    
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

struct SummaryListenButtonFunView: View {
    
    var articleIndex: Int
    
    @ObservedObject var newsManager: NewsManager
    
    let buttonWidth:CGFloat = (UIScreen.main.bounds.width - 60)/2
    
    @StateObject var viewModel = LatestNewsViewModel()
    
    var body: some View {
        Button {
            viewModel.read(message: newsManager.articlesArray[articleIndex].summary, languageCode: "en-US")
        } label: {
            ZStack{
                Capsule()
                    .foregroundColor(Color("BackgroundGray"))
                    .frame(width: buttonWidth, height: 50)
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                if !viewModel.isSpeaking{
                Image(systemName: "speaker.wave.2")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                }   else {
                    EqualizerAnimation()
                        .frame(width: 30, height: 30)
                }
            }
        }
        
    }
}

struct SummaryLikeButtonFunView: View {
    
    var articleIndex: Int
    
    @ObservedObject var newsManager: NewsManager
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Article.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Article.idNum, ascending: true)
    ]) var likedArticles: FetchedResults<Article>
    
    let buttonWidth:CGFloat = (UIScreen.main.bounds.width - 60)/2
    
    var body: some View {
        Button {
            if checkifArticleLiked() {
                unlikeArticle()
            }   else {
                let article = Article(context: managedObjectContext)
                article.idNum = Int16(newsManager.articlesArray[articleIndex].id)
                article.summary = newsManager.articlesArray[articleIndex].summary
                article.sourceURL = newsManager.articlesArray[articleIndex].sourceURL
                article.newsSite = newsManager.articlesArray[articleIndex].newsSite
                article.title = newsManager.articlesArray[articleIndex].title
                article.imageURL = newsManager.articlesArray[articleIndex].imageURL
                do {
                    try managedObjectContext.save()
                }   catch {
                    print(error)
                }
            }
        } label: {
            ZStack{
                Capsule()
                    .foregroundColor(Color("BackgroundGray"))
                    .frame(width: buttonWidth, height: 50)
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                Image(systemName: "heart.fill")
                    .font(.system(size: 20))
                    .foregroundColor(checkifArticleLiked() ? Color(#colorLiteral(red: 0.9149905443, green: 0.2920166254, blue: 0.4980185628, alpha: 0.8470588235)) : .gray)
            }
        }
        
    }
    
    fileprivate func unlikeArticle() {
        for article in likedArticles {
            if article.idNum == newsManager.articlesArray[articleIndex].id{
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
    
    fileprivate func checkifArticleLiked() -> Bool {
        
        for article in likedArticles {
            if article.idNum == newsManager.articlesArray[articleIndex].id{
                return true
            }
        }
        
        return false
    }
}

struct ReadFullArticleButtonView: View {
    
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
