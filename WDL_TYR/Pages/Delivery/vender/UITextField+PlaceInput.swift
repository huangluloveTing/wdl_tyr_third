//
//  UITextField+PlaceInput.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/5.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation
import RxSwift

struct PlaceChooiceItem : Equatable {
    public var title:String
    public var id:String
    public var selected:Bool
    public var subItems:[PlaceChooiceItem]?
    public var level:Int
    
    public static func ==(lrh:PlaceChooiceItem , rhs:PlaceChooiceItem) -> Bool {
        if lrh.title == rhs.title && lrh.id == rhs.id {
            return true
        }
        else {
            return false
        }
    }
}

extension UITextField {
    func placeInputView(items:[PlaceChooiceItem]) -> PublishSubject<(PlaceChooiceItem?,PlaceChooiceItem?,PlaceChooiceItem?)> {
        let ob = PublishSubject<(PlaceChooiceItem?,PlaceChooiceItem?,PlaceChooiceItem?)>()
        self.keyboardToolbar.isHidden = true
        let placeInputView = Bundle.main.loadNibNamed("XIBViews", owner: nil, options: nil)?.first as! DeliveryPlaceChooiceView
        placeInputView.frame = CGRect(origin: .zero, size: CGSize(width: IPHONE_WIDTH, height: IPHONE_WIDTH * 1.2))
        let placeChooiceView = PlaceChooiceView(items: items)
        placeInputView.insertContentView(inputView: placeChooiceView, targetTextField: self)
        self.inputView = placeInputView
        placeInputView.shadow(color: UIColor(hex: COLOR_SHADOW), offset: CGSize(width: 0, height: -2), opacity: 0.5, radius: 2)
        placeChooiceView.placeClosure = { (province , city , strict) in
            ob.onNext((province , city , strict))
        }
        
        return ob
    }
    
    func truckTypeInputView(truckTypes:[TruckTypeItem]) -> PublishSubject<[TruckTypeItem]> {
        let observable = PublishSubject<[TruckTypeItem]>()
        self.keyboardToolbar.isHidden = true
        let truckTypeInputView = Bundle.main.loadNibNamed("XIBViews", owner: nil, options: nil)?.first as! DeliveryPlaceChooiceView
        truckTypeInputView.frame = CGRect(origin: .zero, size: CGSize(width: IPHONE_WIDTH, height: IPHONE_WIDTH * 1.1))
        let truckTypeView = DeliveryTruckTypeView(frame: truckTypeInputView.bounds, truckItems: truckTypes)
        var newTypes:[TruckTypeItem] = truckTypes
        truckTypeView.truckClosure = { (section , row) in
            newTypes = self.toConfigTruckItem(section: section, row: row, types: newTypes)
        }
        truckTypeInputView.insertContentView(inputView: truckTypeView, targetTextField: self)
        truckTypeInputView.shadow(color: UIColor(hex: COLOR_SHADOW), offset: CGSize(width: 0, height: -2), opacity: 0.5, radius: 2)
        self.inputView = truckTypeInputView
        truckTypeInputView.closure = {
            observable.onNext(newTypes)
        }
        return observable
    }
    
    private func toConfigTruckItem(section:Int , row:Int , types:[TruckTypeItem]) -> [TruckTypeItem] {
        var items = types
        items = items.enumerated().map { (offset , item) -> TruckTypeItem in
            var newItem = item
            let specs = newItem.specs
            if offset == section {
                let newSpecs = specs.enumerated().map({ (offset , spec) -> TruckSpecItem in
                    var newSpec = spec
                    if offset == row {
                        newSpec.selected = true
                    } else {
                        newSpec.selected = false
                    }
                    return newSpec
                })
                
                newItem.specs = newSpecs
            }
            return newItem
        }
        
        return items
    }
}
