//
//  BageView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/25.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class BageView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func badgeValue(text:String?) {
        self.badgeLabel.text = " \(text ?? "") "
        self.badgeLabel.sizeToFit()
    }
    
    func badgeColor(color:UIColor?) {
        self.badgeLabel.textColor = color
    }
    
    func bgColor(bgColor:UIColor)  {
        self.backgroundColor = bgColor
    }
    
    func bgImage(image:UIImage)  {
        self.imageView.image = image
    }
    
    func textFont(font:UIFont = UIFont.systemFont(ofSize: 9)) {
        self.badgeLabel.font = font
        self.badgeLabel.sizeToFit()
    }
    
    private lazy var imageView:UIImageView = {
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        return imageView
    }()
    
    private lazy var badgeLabel:UILabel = {
        var badgeLabel = UILabel()
        badgeLabel.backgroundColor = UIColor.red
        return badgeLabel
    }()
    
    override func layoutSubviews() {
        self.addSubview(self.imageView)
        self.imageView.frame = self.bounds
        self.addSubview(self.badgeLabel)
        let frame = self.bounds
        var labelFrame = self.badgeLabel.frame
        labelFrame.origin.x = frame.size.width - labelFrame.size.width / 2
        labelFrame.origin.y =  -labelFrame.size.height / 2
        labelFrame.size.height = labelFrame.size.width
        self.badgeLabel.frame = labelFrame
        self.badgeLabel.addBorder(color: nil, width: 0, radius: Float(labelFrame.size.height / 2.0))
    }
    
}

extension BageView {
    
}
