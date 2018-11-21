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
    case ItemDelete(IndexPath) // 删除item
    case Refresh(items:[T])                 // 刷新数据
    case LoadMore(items:[T])                // 加载更多
}

class BaseVC: UIViewController {
    
    public var showLeftBack:Bool = true // 是否显示左边返回
    
    public var dispose = DisposeBag()
    
    private var currentSearchBar:MySearchBar?

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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
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
    
    deinit {
        print(" dealloc ")
    }
    
    //MARK: - override
    // 搜索回调
    func currentSearchContent(content:String) -> Void { }
}


// 搜索及消息
extension BaseVC {
    
    // 添加头部搜索条
    func addNaviHeader(placeholder:String?="") {
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: IPHONE_WIDTH - 70, height: 44))
        let searchBar = MySearchBar(frame: CGRect(x: 0, y: 0, width: IPHONE_WIDTH - 70, height: 44))
        searchBar.contentInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 0)
        searchBar.barStyle = UIBarStyle.default
        searchBar.tintColor = UIColor.lightGray
        searchBar.delegate = self
        contentView.addSubview(searchBar)
        searchBar.placeholder = placeholder
        currentSearchBar = searchBar
        contentView.backgroundColor = UIColor.clear
        self.navigationItem.titleView = contentView
    }
    
    
    func addLeftNaviHeader(placeholder:String?="") {
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: IPHONE_WIDTH - 100, height: 44))
        let searchBar = MySearchBar(frame: CGRect(x: 0, y: 0, width: IPHONE_WIDTH - 100, height: 44))
        searchBar.contentInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 0)
        searchBar.barStyle = UIBarStyle.default
        searchBar.tintColor = UIColor.lightGray
        searchBar.delegate = self
        contentView.addSubview(searchBar)
        searchBar.placeholder = placeholder
        currentSearchBar = searchBar
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
    
    /**
     * 关闭j搜索键盘
     */
    func registerSearchBar() -> Void {
        currentSearchBar?.resignFirstResponder()
    }
    
}

// navigationBar
extension BaseVC {
    private func configNavigationBar() {
        if showLeftBack == true {
            self.backBarButtonItem()
        }
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

extension BaseVC : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.currentSearchContent(content: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
}


// 获取省市区 数据
extension BaseVC  {
    func loadAllAreas() -> Observable<[RegionModel]> {
        let areaObservable = PublishSubject<[RegionModel]>()
        BaseApi.request(target: API.loadTaskInfo(), type: BaseResponseModel<[RegionModel]>.self)
            .retry(10)
            .subscribe(onNext: { (data) in
                areaObservable.onNext(data.data ?? [])
            })
            .disposed(by: dispose)
        return areaObservable
    }
    
    func loadAllAreaAndStore(callBack:(()->())? = nil) -> Void {
        loadAllAreas().asObservable()
            .subscribe(onNext: { (datas) in
                WDLCoreManager.shared().regionAreas = datas
            })
            .disposed(by: dispose)
    }
}
