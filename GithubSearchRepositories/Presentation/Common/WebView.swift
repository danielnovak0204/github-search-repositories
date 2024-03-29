//
//  WebView.swift
//  GithubSearchRepositories
//
//  Created by Dániel Novák on 29/01/2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: url) else {
            return
        }
        uiView.load(URLRequest(url: url))
    }
}

#Preview {
    WebView(url: previewGithubRepositories.first!.htmlUrl)
}
