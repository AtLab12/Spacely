//
//  WebView.swift
//  Spacely
//
//  Created by Mikolaj Zawada on 19/10/2021.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}

class WebViewModel: ObservableObject{
    let webView: WKWebView
    
    init(url: URL) {
        webView = WKWebView(frame: .zero)
        loadUrl(url: url)
    }
    
    func loadUrl(url: URL) {
        webView.load(URLRequest(url: url))
    }
}
