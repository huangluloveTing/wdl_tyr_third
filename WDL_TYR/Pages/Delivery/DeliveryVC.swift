//
//  DeliveryVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

struct PlaceCheckModel { // 省市区
    var province:PlaceChooiceItem?
    var city:PlaceChooiceItem?
    var strict:PlaceChooiceItem?
}

enum DeliveryMethod { // 成交方式
    case Delivery_Auto // 自动成交
    case Delivery_Manul// 手动成交
}

struct DeliveryCommitModel {
    var vehicleWidth:String?        // 车宽
    var vehicleLength:String?       // 车长
    var vehicleType:String?         // 车型
    var goodsCate:String?           // 货品分类
    var packageType:String?         // 包装类型
    var goodsWeight:String?         // 货物重量
    var loadTime:String?            // 装货时间
    var validTime:String?           // 货物有效期
    var postType:DeliveryMethod?    // 成交方式
    var dealTime:String?            // 成交时间 --- 自动成交方式
    var remark:String?              // 备注
    var unit:String?                // 单价
    var total:String?               // 总价
}

class DeliveryVC: MainBaseVC {
    
    private var startPlace:PlaceCheckModel = PlaceCheckModel()
    private var endPlace:PlaceCheckModel = PlaceCheckModel()
    
    private var hallItems:HallModels?
    private var deliveryData:DeliveryCommitModel? = DeliveryCommitModel()
    
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
        self.loadAllBasicInfo()
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
        self.addMessageRihgtItem()
    }

    override func bindViewModel() {
        self.loadGoodsTimeTextField.datePickerInput(mode: .dateAndTime)
            .asObservable()
            .subscribe(onNext: { (time) in
            
            })
            .disposed(by: dispose)
        
        self.autoPostButton.rx.tap.asObservable()
            .subscribe(onNext: { () in
                self.autoPostButton.isSelected = true
                self.isAutoPost(auto: self.autoPostButton.isSelected)
            })
            .disposed(by: dispose)
        
        self.manualPostButton.rx.tap.asObservable()
            .subscribe(onNext: { () in
                self.autoPostButton.isSelected = false
                self.isAutoPost(auto: self.autoPostButton.isSelected)
            })
            .disposed(by: dispose)
    }
    
    
    func isAutoPost(auto:Bool) { // 是否自动提交
        self.manualPostButton.isSelected = !auto
        self.autoPostButton.isSelected = auto
        self.deliveryData?.postType = auto ? DeliveryMethod.Delivery_Auto : DeliveryMethod.Delivery_Manul
        if auto == true {
            self.dealTimeTextField.updateHeight(height: 48).isHidden = false
        }else {
            self.dealTimeTextField.hiddenByUpdateHeight()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DeliveryVC {
    
    // 车长车宽车型
    private func toConfigSingleInput() {
        self.cartTypeTextField.truckTypeInputView(truckTypes: self.cartSpec() ?? [])
            .subscribe(onNext: { (selected) in
                self.configTruckType(types: selected)
            })
            .disposed(by: dispose)
    }
    
    // 货品分类
    private func toConfigCate() {
        self.goodsCategoryTextField.oneChooseInputView(titles: self.toConfigGoodsCate())
            .subscribe(onNext: { (index) in
                
            })
            .disposed(by: dispose)
    }
    
    // 包装类型
    private func toConfigPackage() {
        self.packageTextField.oneChooseInputView(titles: self.toConfigPackageTypeData())
            .subscribe(onNext: { (index) in
                
            }).disposed(by: dispose)
    }
    
    // 货源有效期
    private func toConfigValid() {
        self.goodsValidTextField.oneChooseInputView(titles: self.toConfigValidTime())
            .subscribe(onNext: { (index) in
                
            })
            .disposed(by: dispose)
    }
    
    private func toConfigAutoPost() {
        self.dealTimeTextField.oneChooseInputView(titles: self.toConfigAutoPostTimeData())
            .subscribe(onNext: { (index) in
                
            })
            .disposed(by: dispose)
    }
    
    // 配置地点输入的弹出
    private func toConfigAreaInput() {
        let items = self.initialProinve().share(replay: 1)
        items.map { (areas) -> PublishSubject<(PlaceChooiceItem?,PlaceChooiceItem?,PlaceChooiceItem?)> in
                return self.startPlaceTextField.placeInputView(items: areas)
            }
            .subscribe(onNext: { [weak self](input) in
                input.subscribe(onNext: { (arg0) in
                    let (province, city, strict) = arg0
                    self?.toRefreshStartPlace(province: province, city: city, strict: strict)
                })
                    .disposed(by: (self?.dispose)!)
            })
            .disposed(by: dispose)
        items.map { (areas) -> PublishSubject<(PlaceChooiceItem?,PlaceChooiceItem?,PlaceChooiceItem?)> in
            return self.endTextField.placeInputView(items: areas)
            }
            .subscribe(onNext: { [weak self](input) in
                input.subscribe(onNext: { (arg0) in
                    let (province, city, strict) = arg0
                    self?.toRefreshEndPlace(province: province, city: city, strict: strict)
                })
                    .disposed(by: (self?.dispose)!)
            })
            .disposed(by: dispose)
        
    }
    
    // 刷新视图
    // 开始地点
    func toRefreshStartPlace(province:PlaceChooiceItem? , city:PlaceChooiceItem? , strict:PlaceChooiceItem?) {
        self.startPlace = PlaceCheckModel(province: province, city: city, strict: strict)
        self.startPlaceTextField.text = (province?.title ?? "") + (city?.title ?? "") + (strict?.title ?? "")
    }
    // 终点
    func toRefreshEndPlace(province:PlaceChooiceItem? , city:PlaceChooiceItem? , strict:PlaceChooiceItem?) {
        self.endPlace = PlaceCheckModel(province: province, city: city, strict: strict)
        self.endTextField.text = (province?.title ?? "") + (city?.title ?? "") + (strict?.title ?? "")
    }
    
    //MARK: 配置省市区
    func initialProinve() -> Observable<[PlaceChooiceItem]> {
        let observable = Observable<[PlaceChooiceItem]>.create { (obser) -> Disposable in
             let areas = Util.configServerRegions(regions: WDLCoreManager.shared().regionAreas ?? [])
            obser.onNext(areas)
            obser.onCompleted()
            return Disposables.create()
        }
        return observable
    }
    
    // 配置车长车型
    private func configTruckType(types:[TruckTypeItem]) {
        let length = types.first?.specs.filter({ (item) -> Bool in
            return item.selected
        }).first
        let width = types[1].specs.filter { (item) -> Bool in
            return item.selected
        }.first
        let type = types.last?.specs.filter({ (item) -> Bool in
            return item.selected
        }).first
        
        self.deliveryData?.vehicleLength = length?.specName
        self.deliveryData?.vehicleWidth = width?.specName
        self.deliveryData?.vehicleType = type?.specName
        var truckTitle = ""
        if let length = length {
            truckTitle = truckTitle + length.specName + "、"
        }
        if let width = width {
            truckTitle = truckTitle + width.specName + "、"
        }
        if let type = type {
            truckTitle = truckTitle + type.specName
        }
        self.cartTypeTextField.text = truckTitle
    }
}

extension DeliveryVC {
    
    func loadAllBasicInfo() {
        self.showLoading(title: "正在拉取，请稍等...", canInterface: true)
        let areaObservable = BaseApi.request(target: API.loadTaskInfo(), type: BaseResponseModel<[RegionModel]>.self)
        let hallObservable = BaseApi.request(target: API.getCreateHallDictionary(), type: BaseResponseModel<HallModels>.self)
        
        Observable.zip(areaObservable , hallObservable).asObservable()
            .subscribe(onNext: { [weak self](result) in
                self?.hiddenToast()
                let (regions , hall) = result
                self?.hallItems = hall.data
                WDLCoreManager.shared().regionAreas = regions.data
                self?.toConfigAreaInput()
                self?.toConfigSingleInput()
                self?.toConfigCate()
                self?.toConfigValid()
                self?.toConfigPackage()
                self?.toConfigAutoPost()
            }, onError: { [weak self](error) in
                self?.hiddenToast()
                self?.loadAllBasicInfo()
            })
            .disposed(by: dispose)
    }
    
    // 配置车长车型的数据
    private func cartSpec() -> [TruckTypeItem]? {
        var length = TruckTypeItem(typeName: "车长", specs: [])
        let length_items = self.hallItems?.VehicleLength?.map({ (item) -> TruckSpecItem in
            let spec_item = TruckSpecItem(specName: item.dictionaryName ?? "", id: item.id ?? "", selected: false)
            return spec_item
        })
        length.specs = length_items ?? []
        var width = TruckTypeItem(typeName: "车宽", specs: [])
        let width_items = self.hallItems?.VehicleWidth?.map({ (item) -> TruckSpecItem in
            let spec_item = TruckSpecItem(specName: item.dictionaryName ?? "", id: item.id ?? "", selected: false)
            return spec_item
        })
        width.specs = width_items ?? []
        
        var cartType = TruckTypeItem(typeName: "车型", specs: [])
        let type_items = self.hallItems?.VehicleType?.map({ (item) -> TruckSpecItem in
            let spec_item = TruckSpecItem(specName: item.dictionaryName ?? "", id: item.id ?? "", selected: false)
            return spec_item
        })
        cartType.specs = type_items ?? []
        
        return [length , width , cartType]
    }
    
    // 货品分类数据
    func toConfigGoodsCate() -> [String] {
        var items : [String] = []
        self.hallItems?.MaterialType?.forEach({ (item) in
            items.append(item.dictionaryName ?? " ")
        })
        return items
    }
    
    // 包装类型数据
    func toConfigPackageTypeData() -> [String] {
        var items : [String] = []
        self.hallItems?.PACKAGE_TYPE?.forEach({ (item) in
            items.append(item.dictionaryName ?? " ")
        })
        return items
    }
    
    // 货物有效期时间
    func toConfigValidTime() -> [String] {
        var items: [String] = []
        self.hallItems?.HYYXQ?.forEach({ (item) in
            items.append(item.dictionaryName ?? " ")
        })
        return items
    }
    
    func toConfigAutoPostTimeData() -> [String] {
        var items: [String] = []
        self.hallItems?.auto_deal_space?.forEach({ (item) in
            items.append(item.dictionaryName ?? " ")
        })
        return items
    }
}
