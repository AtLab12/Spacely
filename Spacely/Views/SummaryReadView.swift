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
    @State var language = LanguageCodes.englishUS
    
    @ObservedObject var newsManager: NewsManager
    
    @StateObject var viewModel = LatestNewsViewModel()
    
    @Binding var showTapBar: Bool
    
    @State var presentWebArticleSheet = false
    @State var showChooseLanguageView = false
    @State var originalMessageProperties = (title: "", summary: "")
    
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
                .blur(radius: showChooseLanguageView ? 10 : 0)
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
                            Text(originalMessageProperties.title == "" ? newsManager.articlesArray[articleIndex].title : originalMessageProperties.title)
                                .font(.custom("Nunito-ExtraBoldItalic", size: 23))
                                .padding(.leading, 20)
                                .padding(.top, 20)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        
                        HStack {
                            Text(originalMessageProperties.summary == "" ? newsManager.articlesArray[articleIndex].summary : originalMessageProperties.summary)
                                .font(.custom("Nunito-Bold", size: 15))
                                .lineLimit(15)
                                .padding(.top, 10)
                                .padding(.leading, 20)
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("by \(newsManager.articlesArray[articleIndex].newsSite)")
                                .font(.custom("Nunito-Light", size: 10))
                                .foregroundColor(.gray)
                                .lineLimit(1)
                                .padding(.top, 10)
                                .padding(.leading, 20)
                            
                            Spacer()
                        }
                        
                        
                            
                            
                            HStack(spacing: 10){
                                
                                
                                SummaryListenButtonFunView(articleIndex: articleIndex, newsManager: newsManager, viewModel: viewModel, selectedLanguage: $language, text: $originalMessageProperties)
                                
                                SummaryLikeButtonFunView(articleIndex: articleIndex, newsManager: newsManager, viewModel: viewModel)
                                
                                SummaryTranslateButtonFunView(showChooseLanguageView: $showChooseLanguageView, viewModel: viewModel)
                            }.padding(.horizontal, 20)
                            
                            
                        
                        ReadFullArticleButtonView(presentWebArticleSheet: $presentWebArticleSheet)
                        
                        Spacer()
                        
                    }.padding(.top, 15)
                }.padding(.top, 250)
            }
            .blur(radius: showChooseLanguageView ? 10 : 0)
            
            
            if showChooseLanguageView{
                LanguagesChoiceView(selectedLanguage: $language, text: $originalMessageProperties, showLanguageChoiceView: $showChooseLanguageView, title: newsManager.articlesArray[articleIndex].title, summary: newsManager.articlesArray[articleIndex].summary)
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
                    .font(.custom("Nunito-Bold", size: 14))
                    .foregroundColor(.gray)
            }.padding(.horizontal, 20)
        }.padding(.top, 15)
    }
}
