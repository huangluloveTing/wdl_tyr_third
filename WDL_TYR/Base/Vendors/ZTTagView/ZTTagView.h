//
//  ZTTagView.h
//  B2C
//
//  Created by 黄露 on 2017/12/22.
//  Copyright © 2017年 yingli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTTagItem.h"

@class ZTTagView;
@protocol ZTTagViewDataSource <NSObject>

@optional
- (UIColor *) tagView:(ZTTagView *)tagView backgroundColorForState:(UIControlState)state atIndex:(NSInteger)index;
- (CGFloat) cornerRadiusForTagView:(ZTTagView *)tagView;
- (UIColor *) broaderColorForTagView:(ZTTagView *)tagView atIndex:(NSInteger)index;
- (UIColor *) broaderColorForTagView:(ZTTagView *)tagView;
- (CGFloat) broaderWidthForTagView:(ZTTagView *)tagView;
- (CGFloat) itemHeightForTagView:(ZTTagView *)tagView;
- (UIFont *) textFontForTagView:(ZTTagView *)tagView;
- (UIColor *) tagView:(ZTTagView *)tagView titleColorForState:(UIControlState)state;
- (BOOL) isAutoLayoutForTagView:(ZTTagView *)tagView; //是否是自适应排列
- (NSInteger) perCountForTagView:(ZTTagView *)tagView; //当不是自适应排列时 ， 需要 设置每行的列数，默认是三列
- (CGFloat) tagViewMarginForTagView;

@end

@protocol ZTTagViewDelegate<NSObject>

@optional
- (void) tagView:(ZTTagView *)tagView didTapIndex:(NSInteger)index;

@end

@interface ZTTagView : UIView

@property (nonatomic , assign) id<ZTTagViewDataSource> dataSource;
@property (nonatomic , assign) id<ZTTagViewDelegate> delegate;
@property (nonatomic  , assign) CGFloat preference_maxWidth;

- (void) showTags:(NSArray <ZTTagItem *> *)tags;

- (void) addTags:(NSArray <ZTTagItem *> *)tags;

- (void) addTag:(ZTTagItem *)tag;

- (void) removeTag:(ZTTagItem *)tag;

- (void) removeTagAtIndex:(NSInteger) tag;

@end
