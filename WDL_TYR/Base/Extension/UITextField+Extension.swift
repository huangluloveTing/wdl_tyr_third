//
//  UITextField+extension.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension UITextField {
    
    func leftImage(image:UIImage) {
        let imageView = self.modeImageView()
        imageView.image = image
        imageView.contentMode = UIViewContentMode.center
        self.leftViewMode = UITextFieldViewMode.always
        self.leftView = imageView
    }
    
    func titleTextField(title:String?,
                        indicator:Bool = false ,
                        textColor:UIColor = UIColor(hex: TEXTFIELD_TITLECOLOR) ,
                        fontSize:CGFloat = 15) {
        let label = UILabel()
        label.text = title
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.sizeToFit()
        
        self.leftViewMode = UITextFieldViewMode.always
        self.leftView = label
        
        if indicator == true {
            let imageView = self.modeImageView()
            imageView.image = #imageLiteral(resourceName: "right")
            imageView.sizeToFit()
            self.rightViewMode = UITextFieldViewMode.always
            self.rightView = imageView
        }
    }
    
    func headerTextField(title:String ,
                         textColor:UIColor = UIColor(hex: "999999") ,
                         bgColor:UIColor=UIColor(hex: "DDDDDD"),
                         font:UIFont = UIFont.systemFont(ofSize: 13)) {
        let label = UILabel()
        label.text = title
        label.textColor = textColor
        
        label.font = font
        label.sizeToFit()
        var frame = label.frame
        frame.size.height = self.frame.size.height
        frame.size.width = self.frame.size.height + 10
        label.frame = frame
        label.backgroundColor = bgColor
        label.textAlignment = NSTextAlignment.center
        self.leftViewMode = UITextFieldViewMode.always
        self.leftView = label
    }
    
    private func modeImageView() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.frame.size.height, height: self.frame.size.height)))
        imageView.contentMode = UIViewContentMode.center
        return imageView
    }
}

extension UITextField {
    
    func datePickerInput(mode:UIDatePickerMode , dateFormatter:String = "yyyy-MM-dd") {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = mode
        let _ =  datePicker.rx.date
            .skip(1)
            .takeUntil(self.rx.deallocated)
            .map { (date) in
                Util.dateFormatter(date: date)
            }
            .bind(to: self.rx.text)
        
        self.inputView = datePicker
    }
}
