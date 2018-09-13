//
//  DropPlaceChooiceView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/6.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class DropPlaceChooiceView: UIView {
    
    typealias DropPlaceChooiceClosure = (PlaceChooiceItem? , PlaceChooiceItem? , PlaceChooiceItem?) -> ()

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var sureButton: UIButton!
    @IBOutlet weak var canButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    public var placeItems:[PlaceChooiceItem]?
    public var dropClosure:DropPlaceChooiceClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bottomView.shadow(color: UIColor(hex: "BBBBBB"), offset: CGSize(width: 0, height: -2), opacity: 0.5, radius: 2)
    }
    
    init(frame:CGRect , items:[PlaceChooiceItem]) {
        super.init(frame: frame)
        self.placeItems = items
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private lazy var placeChooiceView:PlaceChooiceView = {
       let view = PlaceChooiceView(items: self.placeItems ?? [])
        view.isUserInteractionEnabled = true
        view.placeClosure = { (province , city , strict) in
            if let closure = self.dropClosure {
                closure(province , city , strict)
            }
        }
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.placeChooiceView.frame = self.contentView.bounds
        self.contentView.addSubview(self.placeChooiceView)
    }
}
