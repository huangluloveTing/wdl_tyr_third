//
//  ZTTagItem.h
//  B2C
//
//  Created by 黄露 on 2017/12/22.
//  Copyright © 2017年 yingli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTTagItem : NSObject

@property (nonatomic , copy) NSString *title;

@property (nonatomic , copy) NSString *parentName;
@property (nonatomic , copy) NSString *parentCode;

@property (nonatomic , assign) BOOL isCheck; //是否选中

@property (nonatomic , copy) NSString *code;

@end
