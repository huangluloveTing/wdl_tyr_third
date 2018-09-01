//
//  BaseVC+Empty.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/30.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation

var emptyKey = "    "
extension BaseVC : DZNEmptyDataSetSource {
    
    private var emptyTitle:String {
        set {
            objc_setAssociatedObject(self, &emptyKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get {
            return (objc_getAssociatedObject(self, &emptyKey) as? String ) ?? "暂无数据"
        }
    }
    
    func emptyTitle(title:String , to scrollView:UIScrollView) {
        self.emptyTitle = title
        scrollView.emptyDataSetSource = self
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let myAttribute = [NSAttributedStringKey.foregroundColor: UIColor(hex: TEXTCOLOR_EMPTY),
                           NSAttributedStringKey.font: UIFont.systemFont(ofSize: 22)] as [NSAttributedStringKey : Any]
        
        let attStr = NSMutableAttributedString(string: self.emptyTitle)
        attStr.addAttributes(myAttribute, range: NSRangeFromString(self.emptyTitle))
        return attStr
    }
}
