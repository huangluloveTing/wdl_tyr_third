//
//  UITableView+RefreshExtension.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/29.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum TableViewState : Int {
    case Refresh
    case LoadMore
    case EndRefresh
//    case NoMoreData
//    case ResetFooter
}


var refreshKey = "refreshKey"
extension UITableView {
    
    private var _freshState : PublishSubject<TableViewState>? {
        set {
            objc_setAssociatedObject(self, &refreshKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &refreshKey) as? PublishSubject
        }
    }
    
    var refreshState:PublishSubject<TableViewState> {
        guard let state = self._freshState else {
            let ob = PublishSubject<TableViewState>()
            self._freshState = ob
            return self._freshState!
        }
        return state
    }
    
    
    
    func pullRefresh() {
        self.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self]() in
            self?.refreshState.onNext(TableViewState.Refresh)
        })
    }
    
    func upRefresh() {
        self.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {[weak self] in
            self?.refreshState.onNext(.LoadMore)
        })
    }
    
    func noFooter() -> Void {
        if let footer = self.mj_footer {
            footer.removeFromSuperview()
        }
    }
    
    func noHeader() -> Void {
        if let header = self.mj_header {
            header.removeFromSuperview()
        }
    }
    
    func noMore() -> Void {
        if let footer = self.mj_footer {
            footer.endRefreshingWithNoMoreData()
        }
    }
    
    func resetFooter() -> Void {
        if let footer = self.mj_footer {
            footer.resetNoMoreData()
        }
    }
    
    func beginRefresh() {
        let headr = self.mj_header
        if let header = headr {
            header.beginRefreshing()
        }
    }
    
    func beginLoadMore() {
        let footer = self.mj_footer
        if let footer = footer {
            footer.beginRefreshing()
        }
    }
    
    func endRefresh() {
        let header = self.mj_header
        let footer = self.mj_footer
        if let header = header {
            header.endRefreshing()
        }
        if let footer = footer {
            footer.endRefreshing()
        }
        self.refreshState.onNext(.EndRefresh)
    }
    
    
    //MARK: - 初始化 tableView 的 预估高度，防止 上拉加载时出现的无限加载
    func initEstmatedHeights() -> Void {
        self.estimatedRowHeight = 0
        self.estimatedSectionHeaderHeight = 0
        self.estimatedSectionFooterHeight = 0
    }
    
    //MARK: - 
    func refreshAndLoadState() -> Observable<TableViewState> {
        return self.refreshState.asObserver().distinctUntilChanged()
            .throttle(2, scheduler: MainScheduler.instance)
            .filter({ (state) -> Bool in
                return state != .EndRefresh
            })
    }
}

extension Reactive where Base : UITableView {
   
    var refresh:Binder<TableViewState> {
        return Binder.init(self.base, binding: { (tableView, state) in
            
        })
    }
}
