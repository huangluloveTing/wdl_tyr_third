//
//  MoreScreenCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/12/12.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class MoreScreenCell: BaseCell {
    
    @IBOutlet weak var selectionNameLabel: UILabel!
    @IBOutlet weak var selectionItemView: ZTTagView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionItemView.dataSource = self
        selectionItemView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension MoreScreenCell {
    func showCurrentItems(items:[MoreScreenSelectionItem] , _ name:String) -> Void {
        self.selectionItemView.showTags(configItemsToTagView(items: items))
        selectionNameLabel.text = name
    }
    
    
    private func configItemsToTagView(items:[MoreScreenSelectionItem]) ->[ZTTagItem] {
        let tagItems = items.map { (item) -> ZTTagItem in
            let tagItem = ZTTagItem()
            tagItem.isCheck = item.select
            tagItem.title = item.title
            return tagItem
        }
        return tagItems
    }
}

extension MoreScreenCell {
    override func tagView(_ tagView: ZTTagView!, backgroundColorFor state: UIControlState, at index: Int) -> UIColor! {
        if state == .normal {
            return UIColor(hex: "F0F0F0")
        }
        return UIColor(hex: "06C06F").withAlphaComponent(0.3)
    }
    
    override func tagView(_ tagView: ZTTagView!, titleColorFor state: UIControlState) -> UIColor! {
        if state == .normal {
            return UIColor(hex: "333333")
        }
        return UIColor(hex: "06C06F")
    }
    
    override func textFont(for tagView: ZTTagView!) -> UIFont! {
        return UIFont.systemFont(ofSize: 13 * IPHONE_RATE)
    }
    
    override func cornerRadius(for tagView: ZTTagView!) -> CGFloat {
        return 3
    }
    
    override func perCount(for tagView: ZTTagView!) -> Int {
        return 4
    }
    
    override func tagViewMarginForTagView() -> CGFloat {
        return 12 * IPHONE_RATE;
    }
    
    func broaderColor(for tagView: ZTTagView!) -> UIColor! {
        return UIColor.white
    }
    
    func tagView(_ tagView: ZTTagView!, didTap index: Int) {
        
    }
}
