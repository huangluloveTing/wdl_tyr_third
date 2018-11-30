//
//  WayBillStatusView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/1.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

enum WayBillStatus:Int {
    case NOT_Start   = -1  // 未开始
    case Start = 1         // 待起运
    case Transporting = 2   // 运输中
    case ToReceive = 3      // 待签收
    case Done = 4           // 完成
    case willToDo = 0          // 待办单
}

enum ShowCommentType {
    case Four
    case Five
}

class WayBillStatusView: UIView {
    
    public var showType:ShowCommentType = .Four
    
    private var _status : WayBillStatus = WayBillStatus.NOT_Start
    public var status:WayBillStatus! {
        set {
            _status = newValue
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        get {
            return _status
        }
    }
    private var processView:WayBillProcessView!
    private var processItems:[WayBillProcessItem]?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialProcessItems()
        self.initialProcessView()
    }
    
    init(frame:CGRect , type:ShowCommentType) {
        super.init(frame: frame)
        self.showType = type
        self.initialProcessItems()
        self.initialProcessView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.toConfigProcessView()
    }
    
    private func toConfigProcessView() {
        let value = CGFloat((self.showType == .Five) ? self.status.rawValue + 1 : self.status.rawValue)
        self.processView.currentProccess = (value <= 0 ? 1 : value) / (showType == .Four ? 4 : 5)
        self.updateStatus()
    }
    
    private func initialProcessView() {
        self.processView = WayBillProcessView(frame: self.bounds)
        self.processView.padding = (showType == .Five) ? 15 : 45
        self.addSubview(self.processView)
    }
    
    private func initialProcessItems() {
        self.processItems = []
        switch self.showType {
        case .Four:
            self.proccessItemsFour()
            break
        default:
            self.proccessItemsFive()
        }
    }
    
    //MARK: - four
    func proccessItemsFour() -> Void {
        let item1 = WayBillProcessItem(title: "待起运", normalImage: image_waybill_notShip!, focusImage: image_waybill_ship!, focus: false)
        let item2 = WayBillProcessItem(title: "运输中", normalImage: image_waybill_notTrans!, focusImage: image_waybill_trans!, focus: false)
        let item3 = WayBillProcessItem(title: "待签收", normalImage: image_waybill_notrecevie!, focusImage: image_waybill_receive!, focus: false)
        let item4 = WayBillProcessItem(title: "已签收", normalImage: image_waybill_willdone!, focusImage: image_waybill_done!, focus: false)
        self.processItems?.append(item1)
        self.processItems?.append(item2)
        self.processItems?.append(item3)
        self.processItems?.append(item4)
    }
    //MARK: - five
    func proccessItemsFive() -> Void {
        let item0 = WayBillProcessItem(title: "待办单", normalImage: image_waybill_notTodo!, focusImage: image_waybill_todo!, focus: false)
        let item1 = WayBillProcessItem(title: "待起运", normalImage: image_waybill_notShip!, focusImage: image_waybill_ship!, focus: false)
        let item2 = WayBillProcessItem(title: "运输中", normalImage: image_waybill_notTrans!, focusImage: image_waybill_trans!, focus: false)
        let item3 = WayBillProcessItem(title: "待签收", normalImage: image_waybill_notrecevie!, focusImage: image_waybill_receive!, focus: false)
        let item4 = WayBillProcessItem(title: "已签收", normalImage: image_waybill_willdone!, focusImage: image_waybill_done!, focus: false)
        self.processItems?.append(item0)
        self.processItems?.append(item1)
        self.processItems?.append(item2)
        self.processItems?.append(item3)
        self.processItems?.append(item4)
    }
    
    private func updateStatus() {
        var items:[WayBillProcessItem] = []
        for item in self.processItems! {
            var newItem = item
            newItem.focus = false
            items.append(newItem)
        }
        
        if showType == .Four {
            if self.status == .NOT_Start {
                self.processView.items = items
            }
            if self.status == .Start {
                items[0].focus = true
                self.processView.items = items
            }
            if self.status == .Transporting {
                items[0].focus = true
                items[1].focus = true
                self.processView.items = items
            }
            if self.status == .ToReceive {
                items[0].focus = true
                items[1].focus = true
                items[2].focus = true
                self.processView.items = items
            }
            if self.status == .Done {
                items[0].focus = true
                items[1].focus = true
                items[2].focus = true
                items[3].focus = true
                self.processView.items = items
            }
        }
        
        if showType == .Five {
            if self.status == .NOT_Start {
                self.processView.items = items
            }
            if self.status == .willToDo {
                items[0].focus = true
                self.processView.items = items
            }
            if self.status == .Start {
                items[0].focus = true
                items[1].focus = true
                self.processView.items = items
            }
            if self.status == .Transporting {
                items[0].focus = true
                items[1].focus = true
                items[2].focus = true
                self.processView.items = items
            }
            if self.status == .ToReceive {
                items[0].focus = true
                items[1].focus = true
                items[2].focus = true
                items[3].focus = true
                self.processView.items = items
            }
            if self.status == .Done {
                items[0].focus = true
                items[1].focus = true
                items[2].focus = true
                items[3].focus = true
                items[4].focus = true
                self.processView.items = items
            }
        }
    }
    
}

fileprivate class WayBillProcessView: UIView {
    
    public var padding:CGFloat = 45
    
    private var _currentProccess:CGFloat = 0 //(>= 0 , <=1)
    
    public var currentProccess:CGFloat {
        set {
            _currentProccess = newValue
        }
        get {
            return _currentProccess
        }
    }
    
    private var _items:[WayBillProcessItem]! = []
    public var items:[WayBillProcessItem]! {
        set {
            _items = newValue
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        get {
            return _items
        }
    }
    
    private var processViews:[ProcessItemView]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addHoriLineProcess()
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    init(frame:CGRect , items:[WayBillProcessItem]) {
//        super.init(frame: frame)
//        self.items = item
//    }
    
    func addHoriLineProcess() {
        self.addSubview(self.allProcessLine)
        self.addSubview(self.currentProcessLine)
    }
    
    func loadProcessViews() {
        if self.processViews != nil && (self.processViews?.count)! > 0 {
            for processView in self.processViews!{
                processView.removeFromSuperview()
            }
        }
        self.processViews = []
        let count:CGFloat = CGFloat(self.items.count)
        let width = (self.zt_width - padding * (count - 1)) / count
        let height = self.zt_height
        for (index, item) in self.items.enumerated() {
            let x = CGFloat(index) * (width + padding)
            let frame = CGRect(x: x, y: 0, width: width, height: height)
            let processView = ProcessItemView(frame: frame, item: item)
            self.processViews?.append(processView)
            self.addSubview(processView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var rate = self.currentProccess
        if rate <= 0 {
            rate = 0
        }
        if rate >= 1 {
            rate = 1
        }
        let paddingProcessWidth = (self.zt_width + self.padding) * rate - self.padding / 2.0 - (rate == 1 ? self.padding / 2.0 : 0) - (rate == 1 ? 40 : 20)
        self.currentProcessLine.zt_width = paddingProcessWidth
        self.loadProcessViews()
    }
    
    
    private lazy var allProcessLine:UIView = {
        let line = UIView(frame: CGRect(x: 20, y: 19 , width: self.zt_width - 40, height: 2))
        line.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
        return line
    }()
    
    private lazy var currentProcessLine:UIView = {
        let line = UIView(frame: CGRect(x: 20, y: 19 , width: 0, height: 2))
        line.backgroundColor = UIColor(hex: COLOR_BUTTON)
        return line
    }()
}

fileprivate class ProcessItemView:UIView {
    
    private lazy var imageView:UIImageView = {
       let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        return imageView
    }()
    private lazy var titleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    private var _item:WayBillProcessItem!
    
    public var item:WayBillProcessItem! {
        set {
            self._item = newValue
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        get {
            return _item
        }
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame:CGRect, item:WayBillProcessItem) {
        super.init(frame:frame)
        self.item = item
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutViews()
    }
    
    func layoutViews() {
        let item_height = self.zt_height
        let width = self.zt_width
        self.titleLabel.text = self.item.title
        self.titleLabel.textColor = self.item.focus ? UIColor(hex: TEXTFIELD_TEXTCOLOR) : UIColor(hex: TEXTCOLOR_EMPTY)
        self.titleLabel.sizeToFit()
        self.titleLabel.frame = CGRect(origin: CGPoint(x: 0, y: item_height - self.titleLabel.zt_height), size: CGSize(width: width, height: self.titleLabel.zt_height))
        var center = self.imageView.center
        center.x = self.zt_width / 2.0
        self.imageView.center = center
        self.imageView.image = self.item.focus ? self.item.focusImage : self.item.normalImage
    }
}

struct WayBillProcessItem {
    var title:String
    var normalImage:UIImage
    var focusImage:UIImage
    var focus:Bool
}
