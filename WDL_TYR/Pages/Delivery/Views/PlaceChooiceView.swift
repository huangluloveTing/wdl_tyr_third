//
//  PlaceChooiceView.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/5.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class PlaceChooiceView: UIView  , UICollectionViewDataSource, UICollectionViewDelegate {
    
    // 选择的省市区
    private var provinceItem:PlaceChooiceItem?
    private var cityItem:PlaceChooiceItem?
    private var strictItem:PlaceChooiceItem?
    
    typealias PlaceChooseClosure = (PlaceChooiceItem? , PlaceChooiceItem? , PlaceChooiceItem?) -> ()
    
    
    public var placeClosure:PlaceChooseClosure? // 闭包回调
    
    public var showItems:[PlaceChooiceItem]!    // 数据
    private var tabIndex:Int = 0
    
    private var currentProvinces:[PlaceChooiceItem]?
    private var currentCities:[PlaceChooiceItem]?
    private var currentStricts:[PlaceChooiceItem]?
    
    private var currentShowItems:[PlaceChooiceItem]! // 当前列表显示数据，展示
    
    private var provinceTapIndex:Int = 0
    private var cityTapIndex:Int = 0
    private var strictTapIndex:Int = 0
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(items:[PlaceChooiceItem]) {
        super.init(frame:.zero)
        self.toConfig(items: items)
    }
    
    public func showItems(items:[PlaceChooiceItem]) {
        self.toConfig(items: items)
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    private func initialItems(items:[PlaceChooiceItem]) -> [PlaceChooiceItem] {
        var newItems:[PlaceChooiceItem] = []
        items.enumerated().forEach { (index_1 , item_1) in
            var newItem_1 = item_1
            if index_1 == 0 {
                newItem_1.selected = true
            } else {
                newItem_1.selected = false
            }
            newItems.append(newItem_1)
        }
        return newItems
    }
    
    private func toConfig(items:[PlaceChooiceItem]) {
        self.showItems = self.initialItems(items: items)
        self.provinceItem = self.showItems.first
        self.currentProvinces = items
        self.currentShowItems = items
    }
    
    private lazy var collectionView:UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let width = (IPHONE_WIDTH - 0.0) / 4.0
        let height = CGFloat(40.0)
        flow.itemSize = CGSize(width: width, height: height)
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.sectionInset = UIEdgeInsetsMake(1, 0, 1, -1)
        flow.headerReferenceSize = CGSize(width: IPHONE_WIDTH, height: 50)
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
       let collection = UICollectionView(frame: self.bounds, collectionViewLayout: flow)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor.white
        collection.register(UINib.init(nibName: "\(DeliveryPlaceChooiceCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(DeliveryPlaceChooiceCell.self)")
        collection.register(UINib.init(nibName: "\(DeliveryPlaceTabHeader.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "\(DeliveryPlaceTabHeader.self)")
        
        return collection
    }()
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DeliveryPlaceChooiceCell.self)", for: indexPath) as! DeliveryPlaceChooiceCell
        let row = indexPath.row
        cell.label.text = ""
        if (self.currentShowItems?.count)! > row {
            let item = self.currentShowItems?[indexPath.row]
            cell.label.text = item?.title
            cell.label.textColor = (item?.selected)! ? UIColor(hex: COLOR_BUTTON) : UIColor(hex: TEXTFIELD_TEXTCOLOR)
        }

        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headr = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "\(DeliveryPlaceTabHeader.self)", for: indexPath) as! DeliveryPlaceTabHeader
        
        headr.backgroundColor = UIColor.white
        headr.tabTapClosure = { index in
            self.tapTab(index: index)
        }
        return headr
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tapItem(row: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = ceil(Double((self.currentShowItems ?? []).count) / 4.0)
        return Int(count) * 4
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(self.collectionView)
        self.tapTab(index: self.tabIndex)
    }
    
    //点击选择省市区
    private func tapTab(index:Int) {
        self.tabIndex = index
        if index == 0 {
            self.updateCollectionWhenTap(tabIndex: self.tabIndex, row: self.provinceTapIndex)
        }
        if index == 1 {
            self.updateCollectionWhenTap(tabIndex: self.tabIndex, row: self.cityTapIndex)
        }
        if index == 2 {
            self.updateCollectionWhenTap(tabIndex: self.tabIndex, row: self.strictTapIndex)
        }
    }
    
    private  func tapItem(row:Int) {
        if self.tabIndex == 0 {
            if self.provinceTapIndex != row {
                self.provinceTapIndex = row
                self.cityTapIndex = 0
                self.strictTapIndex = 0
                self.updateCollectionWhenTap(tabIndex: self.tabIndex, row: row)
            }
        }
        if self.tabIndex == 1 {
            if self.cityTapIndex != row {
                self.cityTapIndex = row
                self.strictTapIndex = 0
                self.updateCollectionWhenTap(tabIndex: self.tabIndex, row: row)
            }
        }
        if self.tabIndex == 2 {
            if self.strictTapIndex != row {
                self.strictTapIndex = row
                self.updateCollectionWhenTap(tabIndex: self.tabIndex, row: row)
                self.strictItem = self.currentShowItems[self.strictTapIndex]
            }
        }
        
        self.getSelectedArea()
    }
    
    private func updateCollectionWhenTap(tabIndex:Int , row:Int) {
        self.currentShowItems = self.collectionViewShowItem(tabIndex: tabIndex, row: row)
        self.collectionView.reloadData()
    }
    
    private func collectionViewShowItem(tabIndex:Int , row:Int) -> [PlaceChooiceItem] {
        var newItems : [PlaceChooiceItem] = []
        if tabIndex == 0 {
            for (index , item) in self.showItems.enumerated() {
                var newItem = item
                if index == row {
                    newItem.selected = true
                }else {
                    newItem.selected = false
                }
                newItems.append(newItem)
            }
        }
        if tabIndex == 1 {
            let provinceSelected = self.showItems[self.provinceTapIndex]
            let cities = provinceSelected.subItems ?? []
            for (index , city) in cities.enumerated() {
                var newCity = city
                if index == row {
                    newCity.selected = true
                } else {
                    newCity.selected = false
                }
                newItems.append(newCity)
            }
        }
        if tabIndex == 2 {
            let provinceSelected = self.showItems[self.provinceTapIndex]
            if let cities = provinceSelected.subItems {
                if cities.count > self.cityTapIndex {
                    let citySelected = cities[self.cityTapIndex]
                    let stricts = citySelected.subItems ?? []
                    for (index , strict) in stricts.enumerated() {
                        var newStrict = strict
                        if index == row {
                            newStrict.selected = true
                        } else {
                            newStrict.selected = false
                        }
                        newItems.append(newStrict)
                    }
                }
            }
        }
        
        return newItems
    }
    
    func getSelectedArea() {
        self.provinceItem = nil
        self.cityItem = nil
        self.strictItem = nil
        self.provinceItem = self.showItems[self.provinceTapIndex]
        let cities = self.showItems[self.provinceTapIndex].subItems
        if let cities = cities {
            self.cityItem = cities.count > self.cityTapIndex ? cities[self.cityTapIndex] : nil
            let stricts = self.cityItem?.subItems
            if  let stricts = stricts {
                self.strictItem = stricts.count > self.strictTapIndex ? stricts[self.strictTapIndex] : nil
            }
        }
        if let closure = self.placeClosure {
            closure(self.provinceItem , self.cityItem , self.strictItem)
        }
    }

}
