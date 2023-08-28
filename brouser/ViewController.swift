//
//  ViewController.swift
//  brouser
//
//  Created by Ярослав Вербило on 2023-02-18.
//

import UIKit
import WebKit


class ViewController: UIViewController, WKNavigationDelegate {
    let webview = WKWebView()
    
    let toolbar = UIToolbar()
    
    let backbuttonitem = UIBarButtonItem(systemItem: .rewind)
    let forwardbuttonitem = UIBarButtonItem(systemItem: .fastForward)
    let spacer = UIBarButtonItem(systemItem: .flexibleSpace)
    let refreshbuttonitem = UIBarButtonItem(systemItem: .refresh)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview.navigationDelegate = self
        view = webview
        webview.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        toolbar.items = [backbuttonitem, forwardbuttonitem, spacer, refreshbuttonitem]
        
        NSLayoutConstraint.activate([
            webview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webview.topAnchor.constraint(equalTo: view.topAnchor),
            
            
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //toolbar.topAnchor.constraint(equalTo: webview.bottomAnchor),
            toolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        backbuttonitem.action = #selector(backaction)
        forwardbuttonitem.action = #selector(forwardaction)
        refreshbuttonitem.action = #selector(refreshaction)
        
        
        loadRequest()
    }
    
    @objc func backaction() {
        guard webview.canGoBack else{return}
        webview.goBack()
    }
    
    @objc func forwardaction() {
        guard webview.canGoForward else {return}
        webview.goForward()
    }
    
    @objc func refreshaction() {
        webview.reload()
    }
    
    private func loadRequest() {
        guard let url = URL(string: "https://www.google.com") else {return}
        
        let urlrequest = URLRequest(url: url)
        
        webview.load(urlrequest)
    }
    
    
    
    
    
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

            let url = navigationAction.request.url?.absoluteString
            
            if url!.contains("apple") {
                let url = URL(string: "https:/www.youtube.com")
                webview.load(URLRequest(url: url!))
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
            
        }
    
   
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("didcommit")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didfifnish")
        backbuttonitem.isEnabled = webview.canGoBack
        forwardbuttonitem.isEnabled = webview.canGoForward
    }
    
    
}
