//
//  VKLoginWebView.swift
//  SwiftUI-Course
//
//  Created by andrey.antropov on 14.10.2021.
//

import SwiftUI
import WebKit

struct VKLoginWebView: UIViewRepresentable {
    @ObservedObject var viewModel: LoginViewModel
    let navigationDelegate = WebViewNavigationDelegate()
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        navigationDelegate.viewModel = self.viewModel
        webView.navigationDelegate = navigationDelegate
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let request = buildAuthRequest() {
            uiView.load(request)
        }
    }
    
    private func buildAuthRequest() -> URLRequest? {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: viewModel.cliendId),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: viewModel.version)
        ]
        
        return components.url.map { URLRequest(url: $0) }
    }
}

class WebViewNavigationDelegate: NSObject, WKNavigationDelegate {
    var viewModel: LoginViewModel?
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
                  decisionHandler(.allow)
                  return
              }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        guard let token = params["access_token"],
              let userIdString = params["user_id"],
              let _ = Int(userIdString)
                
        else {
            decisionHandler(.allow)
            return
        }
        
        viewModel!.token = token
        viewModel!.userId = userIdString
        viewModel!.isAuthorized = true
        
        decisionHandler(.cancel)
    }
}
