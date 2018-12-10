//
//  AboutZbnVC.swift
//  WDL_TYR
//
//  Created by Apple on 2018/11/12.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class AboutZbnVC: NormalBaseVC {
    var urlString: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        let webView = UIWebView.init(frame: CGRect(origin: CGPoint.zero, size: CGSize.init(width: IPHONE_WIDTH, height:self.view.frame.size.height)))
        self.view.addSubview(webView)

        webView.loadRequest(URLRequest.init(url: URL.init(string: urlString ?? "")!))
        webView.delegate = self
    }
    
    deinit {
        self.hiddenToast()
    }
}
extension AboutZbnVC: UIWebViewDelegate{
    // 该方法是在UIWebView在开发加载时调用
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("开始加载")
  
        SVProgressHUD .show()
    }
    
    // 该方法是在UIWebView加载完之后才调用
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    // 该方法是在UIWebView请求失败的时候调用
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
        self.showFail(fail: error.localizedDescription, complete: nil)
    }
    
  
    
}
