//
//  DeliveryPlaceTabHeader.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/5.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxSwift

class DeliveryPlaceTabHeader: UICollectionReusableView {
    
    @IBOutlet weak var provinceTab: UIButton!
    @IBOutlet weak var cityTab: UIButton!
    @IBOutlet weak var strictTab: UIButton!
    
    let disposeBag = DisposeBag()
    
    public var tabTapClosure:((Int) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configTab(button: self.provinceTab)
        self.configTab(button: self.cityTab)
        self.configTab(button: self.strictTab)
        self.bindAction()
        self.tapTab(index: 0)
    }
    
    private func configTab(button:UIButton) {
        let size = CGSize(width: IPHONE_WIDTH - CGFloat(12 * 2 - 20 * 2), height: 50)
        button.setBackgroundImage(UIColor(hex: "F6f6f6").captureImage(size: size), for: .normal)
        button.setBackgroundImage(UIColor(hex: COLOR_BUTTON).captureImage(size:size ), for: .selected)
        button.setTitleColor(UIColor.white, for: .selected)
        button.setTitleColor(UIColor(hex: "666666"), for: .normal)
        button.addBorder(color: nil, width: 0, radius: 3)
    }
    
    
    func selectedIndex(index:Int) {
        if index == 0 {
            self.provinceTab.isSelected = true
            self.cityTab.isSelected = false
            self.strictTab.isSelected = false
        }
        if index == 1 {
            self.provinceTab.isSelected = false
            self.cityTab.isSelected = true
            self.strictTab.isSelected = false
        }
        if index == 2 {
            self.provinceTab.isSelected = false
            self.cityTab.isSelected = false
            self.strictTab.isSelected = true
        }
    }
    
    private func bindAction() {
        self.provinceTab.rx.tap.asObservable()
            .subscribe(onNext: { () in
                self.tapTab(index: 0)
            })
            .disposed(by: disposeBag)
        
        self.cityTab.rx.tap.asObservable()
            .subscribe(onNext: { () in
                self.tapTab(index: 1)
            })
            .disposed(by: disposeBag)
        
        self.strictTab.rx.tap.asObservable()
            .subscribe(onNext: { () in
                self.tapTab(index: 2)
            })
            .disposed(by: disposeBag)
    }
    
    func tapTab(index:Int) {
        self.selectedIndex(index: index)
        if let closure = self.tabTapClosure {
            closure(index)
        }
    }
}
