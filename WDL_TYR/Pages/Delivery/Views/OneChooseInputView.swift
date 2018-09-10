//
//  SingleSelectionInputView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/3.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class OneChooseInputView: UIView {
    
    typealias OneChooseTapClosure = (Int) -> ()
    
    public var tapClosure:OneChooseTapClosure?

    private var items:[OneChooseItem]?
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect , items:[OneChooseItem]?) {
        super.init(frame: frame)
        self.items = items
        self.addSubview(self.tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public lazy var tableView : UITableView = {
       let tableView = UITableView(frame: self.bounds, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.separatorInset = UIEdgeInsetsMake(0, -100, 0, 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = UIColor(hex: COLOR_BORDER)
        tableView.tableFooterView = UIView()
        return tableView
    }()
}

extension OneChooseInputView : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell?.textLabel?.textAlignment = .center
            cell?.selectionStyle = .none
        }
        let item = self.items![indexPath.row]
        if item.selected == true {
            cell?.textLabel?.textColor = UIColor(hex: COLOR_BUTTON)
        }
        else {
            cell?.textLabel?.textColor = UIColor(hex: TEXTFIELD_TITLECOLOR)
        }
        cell?.textLabel?.text = item.item
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedItem(indexPath: indexPath)
        if let closure = self.tapClosure {
            closure(indexPath.row)
        }
    }
}

extension OneChooseInputView {
    
    func selectedItem(indexPath:IndexPath) {
        if let items = self.items {
            var newItems:[OneChooseItem] = []
            for (index , item) in items.enumerated() {
                var newItem = item
                if (index == indexPath.row) {
                    newItem.selected = true
                } else {
                    newItem.selected = false
                }
                newItems.append(newItem)
            }
            self.items = newItems
            self.tableView.reloadData()
        }
    }
    
}

struct OneChooseItem {
    var item:String
    var id:String
    var selected:Bool
}

