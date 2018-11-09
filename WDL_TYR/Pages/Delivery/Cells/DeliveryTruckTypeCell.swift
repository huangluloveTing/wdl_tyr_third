//
//  DeliveryTruckTypeCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/6.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class DeliveryTruckTypeCell: BaseCell {
    
    typealias TruckTypeTapClosure = (Int) -> ()
    
    public var tapClosure:TruckTypeTapClosure?
    
    @IBOutlet weak var truckTypeName: UILabel!
    
    @IBOutlet weak var tagView: ZTTagView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configTagView(tagView: self.tagView)
        self.tagView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func tagView(_ tagView: ZTTagView!, didTap index: Int) {
        if let closure = self.tapClosure {
            closure(index)
        }
    }
}

extension DeliveryTruckTypeCell {
    func showTruckType(type:TruckTypeItem) {
        self.truckTypeName.text = type.typeName
        self.configTag(type: type)
    }
    
    private func configTag(type:TruckTypeItem) {
        let specs = type.specs
        let tags = specs.map { (item) -> ZTTagItem in
            let tag = ZTTagItem()
            tag.title = item.specName
            tag.code = item.id
            tag.isCheck = item.selected
            return tag
        }
        
        self.tagView.showTags(tags)
    }
}

extension DeliveryTruckTypeView {
    
    
}


