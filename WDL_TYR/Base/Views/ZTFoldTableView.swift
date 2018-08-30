//
//  ZTFoldTableView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/30.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation

protocol ZTFoldTableViewDataSource {
    func tableView(_ tableView:ZTFoldTableView) -> Int
    func tableView(_ tableView:ZTFoldTableView , cellForRowAt index:IndexPath) -> UITableViewCell
}

class ZTFoldTableView: UIView {
    
    public var dataSource:ZTFoldTableViewDataSource!
    
    private var _maxWidth:CGFloat = IPHONE_WIDTH
    
    public var maxWidth:CGFloat {
        set {
            self._maxWidth = newValue
        }
        get {
            return self._maxWidth
        }
    }
    
    private var totalHeight : CGFloat = 0
    
    private lazy var tableView:UITableView = {
       return self.configTableView()
    }()
    
    override var intrinsicContentSize: CGSize {
        self.addSubview(self.tableView)
        self.tableView.reloadData()
        self.tableView.frame = CGRect(x: 0, y: 0, width: self.maxWidth, height: self.totalHeight)
        return CGSize(width: self.maxWidth, height: self.totalHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension ZTFoldTableView : UITableViewDataSource {
    
    func configTableView() -> UITableView {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.tableView(self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.dataSource.tableView(self, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.cellForRow(at: indexPath)
        let cellHeight = cell?.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        let showSeperate = tableView.separatorStyle != .none
        let height = cellHeight! + (showSeperate ? CGFloat(1) : CGFloat(0))
        self.totalHeight += height
        return height
    }
}

extension ZTFoldTableView : UITableViewDelegate {
    
}
