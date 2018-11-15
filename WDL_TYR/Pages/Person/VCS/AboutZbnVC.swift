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
        let webView = UIWebView.init(frame: CGRect(origin: CGPoint.zero, size: CGSize.init(width: IPHONE_WIDTH, height:self.view.frame.size.height)))
        self.view.addSubview(webView)
        let urlString = HOST + "/app/common/companyProfile"
        webView.loadRequest(URLRequest.init(url: URL.init(string: urlString)!))
        webView.delegate = self
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
        print("加载完成")
       SVProgressHUD .dismiss()
    }
    
    // 该方法是在UIWebView请求失败的时候调用
    func webView(webView: UIWebView, didFailLoadWithError error: Error?) {
       SVProgressHUD.showError(withStatus: "加载失败")
       SVProgressHUD.dismiss(withDelay: 1.5)
    }
    
  
    
}
