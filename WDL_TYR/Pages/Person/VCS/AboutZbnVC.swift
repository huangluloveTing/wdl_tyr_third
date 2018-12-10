//
//  AboutZbnVC.swift
//  WDL_TYR
//
//  Created by Apple on 2018/11/12.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class AboutZbnVC: NormalBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.title = "关于织布鸟"
        let webView = UIWebView()
        self.view.addSubview(webView)
//        let urlString = HOST + "/app/common/companyProfile"
        webView.snp.makeConstraints { (maker) in
            maker.top.left.right.bottom.equalTo(0)
        }
        let urlString = HOST + "/html/profile.html"
        webView.loadRequest(URLRequest.init(url: URL.init(string: urlString)!))
        webView.delegate = self
    }
    
    deinit {
        self.hiddenToast()
    }
}
extension AboutZbnVC: UIWebViewDelegate{
    // 该方法是在UIWebView在开发加载时调用
    func webViewDidStartLoad(_ webView: UIWebView) {
        showLoading()
    }
    
    // 该方法是在UIWebView加载完之后才调用
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hiddenToast()
    }
    
    // 该方法是在UIWebView请求失败的时候调用
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        showFail(fail: error.localizedDescription, complete: nil)
    }
    
  
    
}
