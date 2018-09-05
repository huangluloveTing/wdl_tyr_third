//
//  DeliveryVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import SnapKit

class DeliveryVC: MainBaseVC {
    
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var startPlaceTextField: UITextField!
    @IBOutlet weak var placeContentView: UIView!
    
    @IBOutlet weak var goodsNameTextField: UITextField!     // 货品名称
    @IBOutlet weak var goodsCategoryTextField: UITextField! // 货品分类
    @IBOutlet weak var goodsWeightTextField: UITextField!   // 货物重量
    @IBOutlet weak var loadGoodsTimeTextField: UITextField! // 装货时间
    @IBOutlet weak var goodsValidTextField: UITextField!    // 货物有效期
    @IBOutlet weak var autoPostButton: UIButton!            // 自动提交按钮
    @IBOutlet weak var dealTimeTextField: UITextField!      // 成交时间
    @IBOutlet weak var amountTextField: UITextField!        // 总价
    @IBOutlet weak var unitTextField: UITextField!          // 单价
    @IBOutlet weak var remarkTextField: UITextField!        // 备注
    @IBOutlet weak var manualPostButton: UIButton!          // 手动提交
    @IBOutlet weak var cartTypeTextField: UITextField!      // 车长车型
    @IBOutlet weak var packageTextField: UITextField!       // 包装类型
    @IBOutlet weak var timerPostButton: UIButton!           // 定时发布按钮
    @IBOutlet weak var surePostButton: UIButton!            // 确认发布按钮
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func currentConfig() {
        self.navigationItem.title = "发布货源"
        self.placeContentView.addBorder(color: nil,radius:10)
        self.startPlaceTextField.leftImage(image: #imageLiteral(resourceName: "start_point"))
        self.endTextField.leftImage(image: #imageLiteral(resourceName: "end_point"))
        
        self.goodsNameTextField.titleTextField(title: "货品名称")
        self.goodsCategoryTextField.titleTextField(title: "货品分类", indicator: true)
        self.packageTextField.titleTextField(title: "包装类型" ,indicator: true)
        self.cartTypeTextField.titleTextField(title: "车长车型", indicator: true)
        self.goodsWeightTextField.titleTextField(title: "货物重量(吨)")
        self.loadGoodsTimeTextField.titleTextField(title: "装货时间", indicator: true)
        self.goodsValidTextField.titleTextField(title: "货物有效期", indicator: true)
        self.dealTimeTextField.titleTextField(title: "成交时间", indicator: true)
        self.unitTextField.headerTextField(title: "单价")
        self.amountTextField.headerTextField(title: "总价")
        self.dealTimeTextField.hiddenByUpdateHeight()
        
        self.timerPostButton.addBorder(color: nil, width: 0, radius: 22)
        self.surePostButton.addBorder(color: nil, width: 0, radius: 22)
        
        self.addRightBarbuttonItem(withTitle: "tap")
    }

    override func bindViewModel() {
        self.timerPostButton.rx.tap
            .subscribe(onNext: { () in
                
            })
            .disposed(by: dispose)
        
        self.goodsCategoryTextField.oneChooseInputView(titles: ["玉米","玉米","玉米","玉米","玉米","玉米","玉米"])
            .asObservable()
            .subscribe(onNext: { (index) in
            })
            .disposed(by: dispose)
        
        self.packageTextField.oneChooseInputView(titles: ["无包装","木桶","纸箱","铁桶","塑料桶"])
            .asObservable()
            .subscribe(onNext: { (index) in
                
            }).disposed(by: dispose)
        
        self.loadGoodsTimeTextField.datePickerInput(mode: .dateAndTime)
            .asObservable()
            .subscribe(onNext: { (time) in
            
            })
            .disposed(by: dispose)
        
        self.startPlaceTextField.rx.tap.asObservable()
            .subscribe(onNext: { () in
                self.startPlaceTextField.resignFirstResponder()
                
            })
            .disposed(by: dispose)
        
        self.endTextField.placeInputView(items: self.initialProinve()).asObservable()
            .subscribe(onNext: { (province , city , strct) in
                
            })
            .disposed(by: dispose)
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DeliveryVC {
    
    //MARK: TODO
    func initialProinve() -> [PlaceChooiceItem] {
        var item_1 :[PlaceChooiceItem] = []
        for index in 0...6 {
            var placeItem = PlaceChooiceItem(title: "四川", id: String(format: "index+%d", index), selected: false, subItems: nil, level: 0)
            var items_2:[PlaceChooiceItem] = []
            
            for index_2 in 0...9 {
                var placeItem_2 = PlaceChooiceItem(title: "成都", id: String(format: "index2+%d", index_2), selected: false, subItems: nil, level: 0)
                var item_3 : [PlaceChooiceItem] = []
                for index_3 in 0...5 {
                    let placeItem_3 = PlaceChooiceItem(title: "龙泉", id: String(format: "index2+%d", index_3), selected: false, subItems: nil, level: 0)
                    item_3.append(placeItem_3)
                }
                placeItem_2.subItems = item_3
                items_2.append(placeItem_2)
            }
            
            placeItem.subItems = items_2
            item_1.append(placeItem)
        }
        return item_1
    }
}
