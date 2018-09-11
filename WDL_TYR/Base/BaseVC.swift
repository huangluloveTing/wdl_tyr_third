//
//  BaseVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxSwift

// 页面操作  -> tableView 的相关操作
enum SupplyGoodsCommand<T> {
    case TapItem(IndexPath , GoodsSupplyVC) // 点击item
    case ItemDelete(IndexPath)              // 删除item
    case Refresh(items:[T])                 // 刷新数据
    case LoadMore(items:[T])                // 加载更多
}

class BaseVC: UIViewController {
    
    public let dispose = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.view.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
        self.currentConfig()
        self.bindViewModel()
        self.configNavigationBar()
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
    
    // MARK: 导航栏的操作
    override func zt_rightBarButtonAction(_ sender: UIBarButtonItem!) {
        
    }
    
    override func zt_leftBarButtonAction(_ sender: UIBarButtonItem!) {
        self.pop()
    }
}


// 搜索及消息
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
        let rightBadgeView = BageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        rightBadgeView.bgImage(image: #imageLiteral(resourceName: "message"))
        rightBadgeView.badgeValue(text: "99")
        rightBadgeView.textFont()
        rightBadgeView.badgeColor(color: UIColor.white)
        rightBadgeView.bgColor(bgColor: UIColor.clear)
        self.addRightBarbuttonItem(with: rightBadgeView)
    }
    
    // 添加下拉展开视图
    /**
     * drop 添加的下拉视图
     * anchorView 锚点视图 -- 确定下拉视图的位置和大小
     */
    func addDropView(drop:UIView,anchorView:UIView) -> DropViewContainer {
        return DropViewContainer(dropView: drop, anchorView: anchorView)
    }
}

// navigationBar
extension BaseVC {
    private func configNavigationBar() {
        self.backBarButtonItem()
    }
}


// 处理tableView
extension BaseVC {
    
    // 注册cell
    func registerCell(nibName:String , for tableView:UITableView) {
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    // 隐藏tableViewCell分割线
    func hiddenTableViewSeperate(tableView:UITableView) {
        tableView.separatorStyle = .none
    }
}
