//
//  DropView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/25.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation

class GoodsSupplyStatusDropView: UIView {
    
    typealias GSStatusCheckClosure = (Int) -> ()
    
    public var isShow:Bool = false
    private var tagTitles:[String]?
    private var opacityView:UIView?
    private var targetView:UIView?
    
    public var checkClosure: GSStatusCheckClosure?
    
    init(frame:CGRect , titles:[String]? , targetView:UIView) {
        self.tagTitles = titles
        self.targetView = targetView
        super.init(frame: frame)
        self.configSubViews()
    }
    
    init(tags:[String]) {
        self.tagTitles = tags
        super.init(frame:CGRect.zero)
        self.configTagView()
    }
    
    func configTagView() {
        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
        self.configTags()
        let tagSize = self.tagView.intrinsicContentSize
        self.tagView.zt_origin = CGPoint.zero
        self.tagView.zt_size = tagSize
        self.frame = self.tagView.frame
        self.addSubview(self.tagView)
    }
    
    func configSubViews() {
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = true
        self.configTags()
        self.opacityView = UIView(frame: self.bounds)
        self.opacityView?.clipsToBounds = true
        self.opacityView?.backgroundColor = UIColor(hex: "292B2A").withAlphaComponent(0.4)
        self.addSubview(self.opacityView!)
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        self.opacityView?.addSubview(bgView)
        let tagSize = self.tagView.intrinsicContentSize
        bgView.frame = CGRect(origin: CGPoint.zero, size: tagSize)
        self.tagView.frame = bgView.bounds
        bgView.addSubview(self.tagView)
        self.opacityView?.singleTap(closure: { [weak self] (view)  in
            self?.animationHidden()
        })
    }
    
    func configTags() {
        var tags:[ZTTagItem] = []
        for title in self.tagTitles ?? [] {
            let item = ZTTagItem()
            item.isCheck = false
            item.title = title
            tags.append(item)
        }
        self.tagView.showTags(tags)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tagView:ZTTagView = {
        let tagView = ZTTagView()
        tagView.delegate = self
        tagView.dataSource = self
        return tagView
    }()
    
    
    //MARK: dataSource
    override func isAutoLayout(for tagView: ZTTagView!) -> Bool {
        return false
    }
    
    override func perCount(for tagView: ZTTagView!) -> Int {
        return 3
    }
    
    override func tagView(_ tagView: ZTTagView!, backgroundColorFor state: UIControlState, at index: Int) -> UIColor! {
        if state == .selected {
            return UIColor(hex: "DCF7E8")
        }
        return UIColor(hex: "F0F0F0")
    }
    
    override func itemHeight(for tagView: ZTTagView!) -> CGFloat {
        return 33
    }
    
    func tagView(_ tagView: ZTTagView!, didTap index: Int) {
        self.selectedIndex(index: index)
        if let closure = self.checkClosure {
            closure(index)
        }
    }
}

extension GoodsSupplyStatusDropView {
    func animationShow() {
        targetView?.addSubview(self)
        self.opacityView?.height = 0
        UIView.animate(withDuration: 0.25) {
            self.opacityView?.height = self.height
            self.isShow = true
        }
    }
    
    func animationHidden() {
        UIView.animate(withDuration: 0.25, animations: {
            self.opacityView?.height = 0
        }) { (finish) in
            if finish == true {
                self.removeFromSuperview()
                self.isShow = false
            }
        }
    }
    
    private func selectedIndex(index:Int) -> Void {
        let newTags = self.tagTitles?.enumerated().map({ (tagIndex ,tag) -> ZTTagItem in
            let item = ZTTagItem()
            item.isCheck = false
            item.title = tag
            if tagIndex == index {
                item.isCheck = true
            }
            return item
        })
        self.tagView.showTags(newTags)
    }
}
