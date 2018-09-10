//
//  DeliveryTruckTypeView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/5.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

struct TruckTypeItem {
    var typeName:String
    var specs:[TruckSpecItem]
}

struct TruckSpecItem {
    var specName:String
    var id:String
    var selected:Bool
}

class DeliveryTruckTypeView: UIView {

    typealias DeliveryTruckClosure = (Int , Int) -> ()
    
    public var truckClosure:DeliveryTruckClosure?
    
    private var specs:[TruckTypeItem]!
    
    init(frame:CGRect , truckItems:[TruckTypeItem]) {
        super.init(frame: frame)
        self.specs = truckItems
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView:UITableView = {
        var tableView = UITableView(frame: self.bounds, style: UITableViewStyle.plain)
        tableView.delegate =  self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "\(DeliveryTruckTypeCell.self)", bundle: nil), forCellReuseIdentifier: "\(DeliveryTruckTypeCell.self)")
        self.addSubview(tableView)
        return tableView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tableView.frame = self.bounds
    }
}


extension DeliveryTruckTypeView : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(DeliveryTruckTypeCell.self)") as! DeliveryTruckTypeCell
        let type = self.specs[indexPath.row]
        cell.showTruckType(type: type)
        cell.tapClosure = { [weak self](row) in
            let section = indexPath.row
            self?.selected(section: section, row: row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.specs.count
    }
    
    func selected(section:Int , row:Int) {
        var type = self.specs[section]
        let newSpecs = type.specs.enumerated().map { (offset , item) -> TruckSpecItem in
            var newItem = item
            if offset == row {
                newItem.selected = true
            } else {
                newItem.selected = false
            }
            return newItem
        }
        type.specs = newSpecs
        self.specs[section] = type
        self.tableView.reloadData()
        if let closure = self.truckClosure {
            closure(section , row)
        }
    }
}
