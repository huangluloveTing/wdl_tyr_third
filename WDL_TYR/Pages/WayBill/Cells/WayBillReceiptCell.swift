//
//  WayBillReceiptCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/18.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class WayBillReceiptCell: BaseCell {

    typealias WayBillReceiptTapClosure = (Int) -> ()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    public var tapClosure:WayBillReceiptTapClosure?
    
    private var receiptList:[ZbnTransportReturn]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension WayBillReceiptCell {
    
    func configCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 135, height: self.collectionView.zt_height)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "\(WayBillReceiptItem.self)", bundle: nil), forCellWithReuseIdentifier: "\(WayBillReceiptItem.self)")
    }
}

extension WayBillReceiptCell : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.receiptList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(WayBillReceiptItem.self)", for: indexPath) as! WayBillReceiptItem
        let receipt = self.receiptList![indexPath.row]
        cell.showReceipt(imageUrl: receipt.returnBillUrl, time: receipt.createTime)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let closure = self.tapClosure {
            closure(indexPath.row)
        }
    }
}

extension WayBillReceiptCell {
    
    func showReceiptInfo(info:[ZbnTransportReturn]) -> Void {
        self.receiptList = info
        self.collectionView.reloadData()
    }
}
