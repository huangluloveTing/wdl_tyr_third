//
//  InputBaseVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/4.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class InputBaseVC<T>: BaseVC {
    
    typealias InputResultClosure = (T) -> ()

    public var targetTextField:UITextField?
    public var resultClosure:InputResultClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLeftBarButtonItem()
        self.addRightBarButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func addRightBarButtonItem() {
        self.addRightBarbuttonItem(withTitle: "确定")
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: COLOR_BUTTON)
    }
    
    func addLeftBarButtonItem() {
        self.addLeftBarbuttonItem(withTitle: "取消")
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(hex: TEXTCOLOR_EMPTY)
    }
    
    override func zt_rightBarButtonAction(_ sender: UIBarButtonItem!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func zt_leftBarButtonAction(_ sender: UIBarButtonItem!) {
        self.dismiss(animated: true, completion: nil)
    }
}
