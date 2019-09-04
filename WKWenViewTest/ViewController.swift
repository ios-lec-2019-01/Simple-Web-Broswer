//
//  ViewController.swift
//  WKWenViewTest
//
//  Created by amadeus on 03/09/2019.
//  Copyright © 2019 DIT Apps. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let request = URLRequest(url: URL(string: "http://m.dit.ac.kr")!)
        //webView?.load(request)
        indicator.isHidden = true
        webView.navigationDelegate = self
    }
    
    // back, forward button 활성화
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
        
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        indicator.isHidden = false
        indicator.startAnimating()
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        webView.goBack()
        webView.reload()
        print("go back")
    }
    
    @IBAction func forwardButtonAction(_ sender: Any) {
        webView.goForward()
        webView.reload()
        print("go forward")
    }
    @IBAction func webReload(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        func searchTextOnGoogle(text: String){
            let textComponent = text.components(separatedBy: " ")
            let searchString = textComponent.joined(separator: "+")
            let url = URL(string: "https://www.google.com/search?q=" + searchString)
            let urlRequest = URLRequest(url: url!)
            webView.load(urlRequest)
        }
        if let urlString = searchTextField.text{
            if urlString.starts(with: "http://") || urlString.starts(with: "https://"){
                let urlRequest = URLRequest(url: URL(string: urlString)!)
                webView.load(urlRequest)
            }else if urlString.contains("www"){
                let urlRequest = URLRequest(url: URL(string: "http://\(urlString)")!)
                webView.load(urlRequest)
            }else{
                searchTextOnGoogle(text: urlString)
            }
        }
        
//        if let urlString = searchTextField.text {
//            let request = URLRequest(url: URL(string: urlString)!)
//            //print(request)
//            webView?.load(request)
//        }
    }
}

