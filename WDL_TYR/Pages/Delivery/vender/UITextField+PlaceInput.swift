//
//  UITextField+PlaceInput.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/5.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation

extension UITextField {
    func placeInputView() {
        let placeInputView = DeliveryPlaceChooiceVC()
        let naviContainer = UINavigationController(rootViewController: placeInputView)
        let view = naviContainer.view
        self.customerInputView(inputView: view, height: IPHONE_HEIGHT * 0.7)
    }
}
