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
    
    private let dropDispose = DisposeBag()
    
    typealias DropTapClosure = (Int) -> ()
    
    public var dropTapClosure:DropTapClosure?
    
    public var dataSource:DropHintViewDataSource?
    
    
    private var tabTitles:[String]?
    private var dropViews:[DropViewItem]?
    
    private var currenDropView:DropViewContainer? // 记录当前的出现的下拉
    private var beforeDropView:DropViewContainer? // 记录即将出现的下拉
    
    private var allTabButton:[MyButton]?
    
    func tabTitles(titles:[String]) {
        self.tabTitles = titles
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutSubTab()
    }
    
    func layoutSubTab() {
        self.dropViews = []
        self.removeSubTypeView(viewType: MyButton.self)
        let tabButtons = self.configSubTabButton()
        self.allTabButton = tabButtons
        let count = tabButtons.count
        let width = (self.zt_width - CGFloat(count - 1)) / CGFloat(count)
        for (index , tab) in tabButtons.enumerated() {
            tab.frame = CGRect(x: (width + 1) * CGFloat(index) , y: 0, width: width, height: self.zt_height)
            self.addSubview(tab)
            tab.rx.tap
                .subscribe(onNext: { [weak self]() in
                    self?.tapTab(at: index)
                })
                .disposed(by: dropDispose)
            self.addSubview(self.seperateLine(to: tab))
            self.addDropView(index: index)
        }
    }
    
    // 点击对应的按钮的操作
    func tapTab(at index:Int) {
        if let tapClosure = self.dropTapClosure {
            tapClosure(index)
        }
        let toDropView = self.dropViews![index].dropView
        if self.currenDropView == toDropView {
            if (self.currenDropView?.isShow)! {
                self.currenDropView?.hiddenDropView()
                self.currentTapTab(index: index)
            } else {
                self.tabButtonAllInactive()
                self.currenDropView?.showDropViewAnimation()
            }
            return
        }
        self.currentTapTab(index: index)
        self.beforeDropView = self.currenDropView
        self.beforeDropView?.hiddenDropView()
        self.currenDropView = toDropView
        self.currenDropView?.showDropViewAnimation()
    }
    
    // 当点击对应的index ， 或者下拉消失时，对应的tab 的改变
    func dropTabChange(index:Int) -> Void {
        
    }
    
    // 一个下拉出现，另外一个 出现
    func dropView(hidden index:Int , show sIndex:Int) -> Void {
        
    }
    
    func currentTapTab(index:Int) {
        for (tabIndex , tab) in (self.allTabButton?.enumerated())! {
            if index == tabIndex {
                tab.isSelected = true
            } else {
                tab.isSelected = false
            }
        }
    }
    
    // 所有的tab 都不选
    func tabButtonAllInactive() {
        for (_ , tab) in (self.allTabButton?.enumerated())! {
            tab.isSelected = false
        }
    }
    
    //添加下拉视图
    func addDropView(index:Int) {
        let view = self.configDropContentView(index: index)
        let dropItem = DropViewItem(dropView: view, index: index)
        self.dropViews?.append(dropItem)
    }
    
    // 根据协议创建下拉视图
    func configDropContentView(index:Int) -> DropViewContainer? {
        guard let dataSource = self.dataSource else {
            print("未实现协议：dropHintView(dropHint:DropHintView , index:Int) -> UIView ")
            return nil
        }
        let dropView = dataSource.dropHintView(dropHint: self, index: index)
        let dropContainerView = DropViewContainer(dropView: dropView, anchorView: self)
        return dropContainerView
    }
    
    func configTabItem(titles:[String]?) -> [TabItem] {
        var tabItems:[TabItem] = []
        if let titles = titles {
            for title in titles {
                let item = TabItem(selected: false, title: title, selectedImage: #imageLiteral(resourceName: "down_other"), defaultImage: #imageLiteral(resourceName: "down_other"))
                tabItems.append(item)
            }
        }
        return tabItems
    }
    
    func configSubTabButton() -> [MyButton] {
        let tabItems = self.configTabItem(titles: self.tabTitles)
        var tabButtons:[MyButton] = []
        for item in tabItems {
            let tabButton = self.configButton(tabItem: item)
            tabButtons.append(tabButton)
        }
        return tabButtons
    }
    
    func configButton(tabItem:TabItem) -> MyButton {
        let myButton = MyButton(type: UIButtonType.custom)
        myButton.setTitle(tabItem.title, for: UIControlState.normal)
        myButton.setImage(tabItem.defaultImage, for: UIControlState.normal)
        myButton.setImage(tabItem.selectedImage, for: UIControlState.selected)
        myButton.setTitleColor(UIColor(hex: "333333"), for: UIControlState.normal)
        myButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return myButton
    }
    
    func seperateLine(to tabButton:MyButton) -> UIView {
        let view = UIView(frame: CGRect(origin: CGPoint(x: tabButton.endX, y: tabButton.zt_y+10), size: CGSize(width: 1, height: tabButton.zt_height-20)))
        view.backgroundColor = UIColor(hex: "E7E7E7")
        return view
    }
}

// 处理下拉视图
extension DropHintView {
    
}

struct TabItem {
    public var selected:Bool?
    public var title:String?
    public var selectedImage:UIImage?
    public var defaultImage:UIImage?
}

struct DropViewItem {
    public var dropView:DropViewContainer?
    public var index:Int
}
