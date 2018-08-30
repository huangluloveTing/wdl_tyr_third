//
//  DropHintView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/25.
//  Copyright © 2018年 yingli. All rights reserved.
//

import RxSwift
import UIKit

protocol DropHintViewDataSource {
    func dropHintView(dropHint:DropHintView , index:Int) -> UIView
}

class DropHintView: UIView {
    
    private var topLine:UIView = {
       let topLine = UIView(frame: CGRect.zero)
        return topLine
    }()
    private var bottomLine:UIView = {
        let bottomLine = UIView(frame: CGRect.zero)
        return bottomLine
    }()
    
    private let dropDispose = DisposeBag()
    
    typealias DropTapClosure = (Int) -> ()
    
    public var dropTapClosure:DropTapClosure? // 点击选项回调
    public var dataSource:DropHintViewDataSource?   // 下拉视图的 视图 代理
    public var topLineColor:UIColor = UIColor(hex: "DDDDDD")
    public var bottomLineColor:UIColor = UIColor(hex: "DDDDDD")
    public var showTopLine:Bool {
        set {
            self.topLine.isHidden = newValue
        }
        get {
            return self.topLine.isHidden
        }
    }
    public var showBottomLine:Bool {
        set {
            self.bottomLine.isHidden = newValue
        }
        get {
            return self.bottomLine.isHidden
        }
    }
    
    private var tabTitles:[String]?
    private var dropViews:[DropViewItem]?
    private var currentIndex:Int?
    
    private var currenDropView:DropViewContainer? // 记录当前的出现的下拉
    private var beforeDropView:DropViewContainer? // 记录即将出现的下拉
    
    private var allTabButton:[MyButton] = []    // 所有的tab 按钮
    private var allTabItems:[TabItem] = []      // items
    private var seperateLines:[UIView] = []     // 中间分割线
    
    
    func tabTitles(titles:[String]) {
        self.tabTitles = titles
        self.allTabItems = self.loadAllTabItems(titles: titles)
        self.addDropView()
        self.renderView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutSubTab()
        self.topLine.frame = CGRect(x: 0, y: 0, width: self.zt_width, height: 0.5)
        self.bottomLine.frame = CGRect(x: 0, y: self.zt_height-1, width: self.zt_width, height: 0.5)
        self.topLine.backgroundColor = self.topLineColor
        self.bottomLine.backgroundColor = self.bottomLineColor
        self.addSubview(self.topLine)
        self.addSubview(self.bottomLine)
    }
    
    private func layoutSubTab() {
        self.removeSubTypeView(viewType: MyButton.self)
        self.removeAllSeprateLines()
        let tabButtons = self.loadAllTabButtons()
        self.allTabButton = tabButtons
        let count = self.allTabButton.count
        let width = (self.zt_width - CGFloat(count - 1)) / CGFloat(count == 0 ? 1 : count)
        for (index , tab) in self.allTabButton.enumerated() {
            tab.frame = CGRect(x: (width + 1) * CGFloat(index) , y: 0, width: width, height: self.zt_height)
            self.addSubview(tab)
            tab.rx.tap
                .subscribe(onNext: { [weak self]() in
                    self?.tapTab(at: index)
                })
                .disposed(by: dropDispose)
            self.addSubview(self.seperateLine(to: tab))
        }
    }
}

// actions
extension DropHintView {
    // 点击对应的按钮的操作
    private func tapTab(at index:Int) {
        if let tapClosure = self.dropTapClosure {
            tapClosure(index)
        }
        self.currentIndex = index
        self.selectedTabItems(tapIndex: index)
        self.showDropView(index: index)
        self.renderView()
    }
    
    // 如果有 下拉视图 就显示 ，没有走回调
    private func showDropView(index:Int) {
        let tabItem = self.allTabItems[index]
        let toDropView = self.dropViews?[index].dropView
        
        // 当前要显示的 dropView 已经显示，则进行显示或者不显示
        if let dropView = toDropView {
            if dropView == self.currenDropView {
                if tabItem.selected {
                    dropView.showDropViewAnimation()
                }
                else {
                    dropView.hiddenDropView()
                }
            }
            else {
                self.currenDropView?.hiddenDropView()
                dropView.showDropViewAnimation()
                self.currenDropView = dropView
            }
        }
        else {
            self.currenDropView?.hiddenDropView()
        }
    }
}

// 初始化 views
extension DropHintView {
    private func loadAllTabButtons() -> [MyButton] {
        let tabItems = self.allTabItems
        var tabButtons:[MyButton] = []
        for item in tabItems {
            let tabButton = self.configButton(tabItem: item)
            tabButtons.append(tabButton)
        }
        return tabButtons
    }
    
    private func loadAllTabItems(titles: [String]?) -> [TabItem] {
        var tabItems:[TabItem] = []
        if let titles = titles {
            for title in titles {
                let item = TabItem(selected: false, title: title, selectedImage: #imageLiteral(resourceName: "tab_up"), defaultImage: #imageLiteral(resourceName: "down_other"))
                tabItems.append(item)
            }
        }
        return tabItems
    }
    
    private func configButton(tabItem:TabItem) -> MyButton {
        let myButton = MyButton(type: UIButtonType.custom)
        myButton.setTitle(tabItem.title, for: UIControlState.normal)
        myButton.setImage(tabItem.defaultImage, for: UIControlState.normal)
        myButton.setImage(tabItem.selectedImage, for: UIControlState.selected)
        myButton.setTitleColor(UIColor(hex: "333333"), for: UIControlState.normal)
        myButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        myButton.isSelected = tabItem.selected
        return myButton
    }
    
    func selectedTabItems(tapIndex:Int) {
        var tabItems = self.allTabItems
        for (index,item) in self.allTabItems.enumerated() {
            if tapIndex == index {
                tabItems[tapIndex].selected =  !item.selected
            }
        }
        self.allTabItems = tabItems
    }
    
    func deselectedTabItem(index:Int) {
        var tabItems = self.allTabItems
        var item = tabItems[index]
        item.selected = false
        tabItems[index] = item
        self.allTabItems = tabItems
    }
    
    func renderView() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}

// 中间分割线
extension DropHintView {
    private func seperateLine(to tabButton:MyButton) -> UIView {
        let view = UIView(frame: CGRect(origin: CGPoint(x: tabButton.endX, y: tabButton.zt_y+10), size: CGSize(width: 1, height: tabButton.zt_height-20)))
        view.backgroundColor = UIColor(hex: "E7E7E7")
        self.seperateLines.append(view)
        return view
    }
    
    private func removeAllSeprateLines() {
        for seperateLine in self.seperateLines {
            seperateLine.removeFromSuperview()
        }
    }
}

// 处理下拉视图
extension DropHintView {
    //添加下拉视图
    private func addDropView() {
        self.removeSubTypeView(viewType: DropViewContainer.self)
        self.dropViews = []
        for (index,_) in self.allTabItems.enumerated() {
            let view = self.configDropContentView(index: index)
            let dropItem = DropViewItem(dropView: view, index: index)
            self.dropViews?.append(dropItem)
        }
    }
    
    // 根据协议创建下拉视图
    private func configDropContentView(index:Int) -> DropViewContainer? {
        guard let dataSource = self.dataSource else {
            print("未实现协议：dropHintView(dropHint:DropHintView , index:Int) -> UIView ")
            return nil
        }
        let dropView = dataSource.dropHintView(dropHint: self, index: index)
        let dropContainerView = DropViewContainer(dropView: dropView, anchorView: self)
        dropContainerView.dismissCompleteClosure = {
            self.deselectedTabItem(index: index)
            self.renderView()
        }
        return dropContainerView
    }
}

struct TabItem {
    public var selected:Bool
    public var title:String?
    public var selectedImage:UIImage?
    public var defaultImage:UIImage?
}

struct DropViewItem {
    public var dropView:DropViewContainer?
    public var index:Int
}
