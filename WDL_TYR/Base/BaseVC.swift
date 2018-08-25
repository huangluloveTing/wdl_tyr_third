//
//  BaseVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxSwift

class BaseVC: UIViewController {
    
    public let dispose = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.currentConfig()
        self.bindViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: 页面配置，针对当前页面配置，只需重写
    func currentConfig()  {
        
    }
    
    // 绑定vm
    func bindViewModel() {
        
    }
}

extension BaseVC {
    
    // 添加头部搜索条
    func addNaviHeader() {
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: IPHONE_WIDTH - 70, height: 44))
        let searchBar = MySearchBar(frame: CGRect(x: 0, y: 0, width: IPHONE_WIDTH - 70, height: 44))
        searchBar.contentInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 0)
        searchBar.barStyle = UIBarStyle.default
        searchBar.rx.text.orEmpty
            .subscribe(onNext: { (text) in
                print("search text ： \(text)")
            })
            .disposed(by: dispose)
        contentView.addSubview(searchBar)
        searchBar.placeholder = "搜索我的运单(运单号、承运人、车牌号、线路)"
        contentView.backgroundColor = UIColor.clear
        self.navigationItem.titleView = contentView
    }
    
    // 添加头部信息
    func addMessageRihgtItem() {
        let rightBadgeView = BageView(frame: CGRect(x: 0, y: 0, width: 33, height: 33))
        rightBadgeView.bgImage(image: #imageLiteral(resourceName: "message"))
        rightBadgeView.badgeValue(text: "99")
        rightBadgeView.textFont()
        rightBadgeView.badgeColor(color: UIColor.white)
        rightBadgeView.bgColor(bgColor: UIColor.clear)
        self.addRightBarbuttonItem(with: rightBadgeView)
    }
}
