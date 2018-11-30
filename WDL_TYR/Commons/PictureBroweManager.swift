//
//  PictureBroweManager.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/30.
//  Copyright © 2018 yinli. All rights reserved.
//

import Foundation


class PictureBroweManager: NSObject {
    
    static let manager = PictureBroweManager()
    private let photoBrower =  LBPhotoBrowserManager.default()
    
    private override init() {
        
    }
    
    static func shard() -> PictureBroweManager {
        return manager
    }
    
    func showPictures(imgItems:[UIImage] , defalutIndex:Int = 0 , imageSuperView:UIView) -> Void {
        let imgs = imgItems.map { (img) -> LBPhotoLocalItem in
            let item = LBPhotoLocalItem()
            item.localImage = img
            item.frame = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
            return item
        }
        photoBrower?.showImage(with: imgs, selectedIndex: defalutIndex, fromImageViewSuperView: imageSuperView)
    }
    
    func showWebPictures(webItems:[String] , defaultIndex:Int = 0 , imageSuperView:UIView) -> Void {
        let imgs = webItems.map { (img) -> LBPhotoWebItem in
            let item = LBPhotoWebItem()
            item.urlString = img
            item.frame = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
            return item
        }
        photoBrower?.showImage(with: imgs, selectedIndex: defaultIndex, fromImageViewSuperView: imageSuperView)
    }
}

