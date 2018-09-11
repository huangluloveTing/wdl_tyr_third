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
            imageView.zt_width = imageView.zt_width + 10
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

// inputView
extension UITextField {
    
    /*时间选择弹出*/
    func datePickerInput(mode:UIDatePickerMode , dateFormatter:String = "yyyy-MM-dd" , skip:Int = 1) -> PublishSubject<TimeInterval>{
        let timeObservable = PublishSubject<TimeInterval>()
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = mode
        let _ =  datePicker.rx.date
            .skip(skip)
            .takeUntil(self.rx.deallocated)
            .share(replay: 1)
            .flatMap({ (date) -> Observable<Date> in
                timeObservable.onNext(date.timeIntervalSince1970)
                return Observable.just(date)
            })
            .map { (date) in
                Util.dateFormatter(date: date)
            }
            .bind(to: self.rx.text)
        self.inputView = datePicker
        
        return timeObservable
    }
    
    func customerInputView(inputView:UIView? , height:CGFloat) {
        inputView?.frame = CGRect(x: 0, y: 0, width: IPHONE_WIDTH, height: height)
        self.inputView = inputView
    }
}

// 单选弹出 的 inputView
extension UITextField {
    func oneChooseInputView(titles:[String]?) -> PublishSubject<Int> {
        let ob = PublishSubject<Int>()
        var items:[OneChooseItem] = []
        if let titles = titles {
            items = titles.map { (title) -> OneChooseItem in
                let oneItem = OneChooseItem(item: title, id: "", selected: false)
                return oneItem
            }
        }
        
        let chooseView = OneChooseInputView(frame: CGRect(x: 0, y: 0, width: IPHONE_WIDTH, height: IPHONE_HEIGHT * 0.4), items: items)
        
        self.customerInputView(inputView: chooseView, height: chooseView.zt_height)
        chooseView.tapClosure = { (index) in
            ob.onNext(index)
            let title = titles![index]
            let _ = Observable.just(title).asObservable()
                .takeUntil(self.rx.deallocated)
                .bind(to: self.rx.text)
        }
        
        return ob
    }
}

extension Reactive where Base : UITextField {
    
    public var tap:ControlEvent<Void> {
        return controlEvent(.editingDidBegin)
    }
}
