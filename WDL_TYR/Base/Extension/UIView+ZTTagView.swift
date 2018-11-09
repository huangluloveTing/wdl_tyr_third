//
//  UIView+ZTTagView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/6.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

// 处理tagView
extension UIView : ZTTagViewDelegate , ZTTagViewDataSource {
    
    func configTagView(tagView:ZTTagView) {
        tagView.delegate = self
        tagView.dataSource = self
    }
    
    /**
     
     - (UIColor *) tagView:(ZTTagView *)tagView backgroundColorForState:(UIControlState)state atIndex:(NSInteger)index;
     - (CGFloat) cornerRadiusForTagView:(ZTTagView *)tagView;
     - (UIColor *) broaderColorForTagView:(ZTTagView *)tagView atIndex:(NSInteger)index;
     - (UIColor *) broaderColorForTagView:(ZTTagView *)tagView;
     - (CGFloat) broaderWidthForTagView:(ZTTagView *)tagView;
     - (CGFloat) itemHeightForTagView:(ZTTagView *)tagView;
     - (UIFont *) textFontForTagView:(ZTTagView *)tagView;
     - (UIColor *) tagView:(ZTTagView *)tagView titleColorForState:(UIControlState)state;
     - (BOOL) isAutoLayoutForTagView:(ZTTagView *)tagView; //是否是自适应排列
     - (NSInteger) perCountForTagView:(ZTTagView *)tagView; //当不是自适应排列时 ， 需要 设置每行的列数，默认是三列
     - (CGFloat) tagViewMarginForTagView;
     */
    
    public func tagView(_ tagView: ZTTagView!, backgroundColorFor state: UIControlState, at index: Int) -> UIColor! {
        if state == .normal {
            return UIColor(hex: COLOR_NORMAL)
        }
        return UIColor(hex: COLOR_BUTTON).withAlphaComponent(0.3)
    }
    
    public func cornerRadius(for tagView: ZTTagView!) -> CGFloat {
        return 4
    }
    
    public func itemHeight(for tagView: ZTTagView!) -> CGFloat {
        return 30
    }
    
    public func isAutoLayout(for tagView: ZTTagView!) -> Bool {
        return false
    }
    
    public func perCount(for tagView: ZTTagView!) -> Int {
        return 4
    }
    
    public func tagViewMarginForTagView() -> CGFloat {
        return 16
    }
    
    public func tagView(_ tagView: ZTTagView!, titleColorFor state: UIControlState) -> UIColor! {
        if state == .normal {
            return UIColor(hex: TEXTFIELD_TITLECOLOR)
        }
        return UIColor(hex: COLOR_BUTTON)
    }
    
    public func textFont(for tagView: ZTTagView!) -> UIFont! {
        return UIFont.systemFont(ofSize: 13)
    }
}
