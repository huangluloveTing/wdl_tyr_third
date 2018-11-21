//
//  MyCarrierSearchCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/20.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MyCarrierSearchCell: BaseCell {
    
    private let dispose = DisposeBag()
    
    typealias MyCarrierSearchClosure = (String)->()

    @IBOutlet weak var searchBar: UISearchBar!
    
    
    public var searchClosure:MyCarrierSearchClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchBar.placeholder = "搜索我的承运人"
        searchBar.rx.text.orEmpty.asObservable()
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self](text) in
                self?.currentSearch(text: text)
            })
            .disposed(by: dispose)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    fileprivate func currentSearch(text:String) -> Void {
        if let closure = self.searchClosure {
            closure(text)
        }
    }
}
