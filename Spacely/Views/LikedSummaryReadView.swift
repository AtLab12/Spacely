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
    
    @State var language = LanguageCodes.englishUS
    @State var presentWebArticleSheet = false
    
    var article: FetchedResults<Article>.Element
    @StateObject var viewModel = LatestNewsViewModel()
    
    @State var showChooseLanguageView = false
    @State var originalMessageProperties = (title: "", summary: "")
    
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
                            Text(originalMessageProperties.title == "" ? article.title ?? "No title" : originalMessageProperties.title)
                                .font(.custom("Nunito-ExtraBoldItalic", size: 23))
                                .padding(.leading, 20)
                                .padding(.top, 20)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        
                        HStack {
                            Text(originalMessageProperties.summary == "" ? article.summary ?? "No summary available" : originalMessageProperties.summary)
                                .font(.custom("Nunito-Bold", size: 15))
                                .lineLimit(15)
                                .padding(.top, 10)
                                .padding(.leading, 20)
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("by \(article.newsSite ?? "Uknown source")")
                                .font(.custom("Nunito-Light", size: 10))
                                .foregroundColor(.gray)
                                .lineLimit(1)
                                .padding(.top, 10)
                                .padding(.leading, 20)
                            
                            Spacer()
                        }
                        
                        HStack(spacing: 10){
                            LikeArticleSummaryListenButtonFunView(article: article, viewModel: viewModel, selectedLanguage: $language, text: $originalMessageProperties)
                            
                            LikeArticleSummaryLikeButtonFunView(article: article, showTapBar: $showTapBar)
                            
                            LikeArticleSummaryTranslateButtonFunView(showChooseLanguageView: $showChooseLanguageView, viewModel: viewModel)
                        }.padding(.horizontal, 20)
                        
                        LikeArticleReadFullArticleButtonView(presentWebArticleSheet: $presentWebArticleSheet)
                        
                        Spacer()
                        
                    }.padding(.top, 15)
                }.padding(.top, 250)
            }
            .blur(radius: showChooseLanguageView ? 10 : 0)
            
            
            if showChooseLanguageView{
                LanguagesChoiceView(selectedLanguage: $language, text: $originalMessageProperties, showLanguageChoiceView: $showChooseLanguageView, title: article.title!, summary: article.summary!)
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
