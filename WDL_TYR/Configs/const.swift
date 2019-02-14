//
//  const.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation

let KF_PHONE_NUM = "03106591999" // 客服电话

let BUTTON_FONT = UIFont.systemFont(ofSize: 16)

let IPHONE_WIDTH = UIScreen.main.bounds.size.width

let IPHONE_HEIGHT = UIScreen.main.bounds.size.height

let IPHONE_RATE = (IPHONE_WIDTH / 375.0) > 1 ? 1 : (IPHONE_WIDTH / 375.0)

//MARK: - 通知中心
let PUSH_MESSAGE_VALUE = "PUSH_MESSAGE_VALUE"

let GAODE_MAP_KEY = "8e99eeada50ef322b5c993eb92acffd6"

let RE_SHELVE_AGREEN_TITLE : String = "收货须知"        // 确认签收收货须知 标题
let RE_SHELVE_AGREEN_CONTENT : String = "1、当您收到货物时，请与送货人员当场验收。\n2、 确认您的商品品牌、名称、数量等产品信息与订单相符。\n3、 包装完好、无雨淋、异味、车厢污染等因在途造成的质量问题。\n4、 确认签收后，即表示您已认可此次交易行为，不再支持因运输产生的其他问题。\n5、 签收成功后如遇到产品自身的质量问题，因联系商品的销售部或客服部门处理。\n"        // 确认签收收货须知 内容

//极光推送的key
let JPushAppKey = "20aeb9ef1cdc4a5185da6bb6"
let JPushMasterSecret = "71b55a4396de63853ad08c68"

//测试环境外网
//let HOST = "http://182.150.21.104:58092/zbn-web"
//测试内网
//let HOST = "http://172.16.8.52:8082/zbn-web"
//deng qing
//let HOST = "http://172.16.59.19:8282"
//zhao xiao yang
//let HOST = "http://172.16.59.73:8082/zbn-web"
//liao bing
//let HOST = "http://172.16.59.47:8082/zbn-web"
//客户的测试环境
//let HOST = "http://221.193.233.227:8010/zbn-web"

