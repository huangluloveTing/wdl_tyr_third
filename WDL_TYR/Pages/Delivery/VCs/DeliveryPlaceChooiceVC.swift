//
//  DeliveryPlaceChooiceVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/5.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class DeliveryPlaceChooiceVC: InputBaseVC<Any> , UICollectionViewDelegate , UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DeliveryPlaceChooiceCell.self)", for: indexPath) as! DeliveryPlaceChooiceCell
        cell.label.text = "北京"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let kindHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            return kindHeader
        }
        
        return UICollectionReusableView(frame: .zero)
    }
}

extension DeliveryPlaceChooiceVC {
    
    func configCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let width = (IPHONE_WIDTH -  CGFloat(3 * 1)) / 3.0
        layout.itemSize = CGSize(width: width, height: 40)
        layout.scrollDirection = .vertical
        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "\(DeliveryPlaceChooiceCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(DeliveryPlaceChooiceCell.self)")
        self.collectionView.register(UINib.init(nibName: "\(DeliveryPlaceTabHeader.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
    }
}
