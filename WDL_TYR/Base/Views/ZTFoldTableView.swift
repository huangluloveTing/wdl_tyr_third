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
    
    private var loadCells:[UITableViewCell] = []
    
    public var maxWidth:CGFloat {
        set {
            self._maxWidth = newValue
        }
        get {
            return self._maxWidth
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(self.tableView)
    }
    
    private var totalHeight : CGFloat = 0
    
    private lazy var tableView:UITableView = {
       return self.configTableView()
    }()
    
    override var intrinsicContentSize: CGSize {
//        self.tableView.frame = CGRect(x: 0, y: 0, width: self.maxWidth, height: self.totalHeight)
        return CGSize(width: self.maxWidth, height: self.totalHeight)
    }
    
    
    public func reload() {
        self.tableView.reloadData()
        self.invalidateIntrinsicContentSize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

// reuse cell
extension ZTFoldTableView {
    func registerCell(nib:UINib? , for identifier:String) {
        self.tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func registerCell(cellClass:AnyClass , for identifier:String) {
        self.tableView.register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell(with identifier: String) -> UITableViewCell? {
        return  self.tableView.dequeueReusableCell(withIdentifier: identifier)
    }
}

extension ZTFoldTableView : UITableViewDataSource {
    
    func configTableView() -> UITableView {
        let tableView = UITableView(frame: self.bounds, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.loadCells = []
        return self.dataSource.tableView(self)
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dataSource.tableView(self, cellForRowAt: indexPath)
        self.loadCells.append(cell)
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = self.loadCells[indexPath.row]
        let cellHeight = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        let showSeperate = tableView.separatorStyle != .none
        let height = cellHeight + (showSeperate ? CGFloat(1) : CGFloat(0))
        self.totalHeight += height
        return height
    }
}

extension ZTFoldTableView : UITableViewDelegate {
    
}
