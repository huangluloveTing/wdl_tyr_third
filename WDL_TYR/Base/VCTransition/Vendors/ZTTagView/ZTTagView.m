//
//  ZTTagView.m
//  B2C
//
//  Created by 黄露 on 2017/12/22.
//  Copyright © 2017年 yingli. All rights reserved.
//

#import "ZTTagView.h"

#define ZTTagView_Margin (13)
#define IPHONE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define iPhone_Rate (IPHONE_WIDTH/375.0)

@interface ZTTagView()

@property (nonatomic , assign) CGFloat max_width;
@property (nonatomic , strong) NSMutableArray *allTags;
@property (nonatomic , strong) NSArray *tag_buttons; // 所以的button

@end
@implementation ZTTagView

- (CGSize) intrinsicContentSize {
    
    [self getAllButton];
    if (self.max_width == 0) {
        self.max_width = [UIScreen mainScreen].bounds.size.width;
    }
    return [self layoutTagButtons];
}

- (void) awakeFromNib {
    [super awakeFromNib];
    self.allTags = [NSMutableArray array];
}

- (void) showTags:(NSArray <ZTTagItem *> *)tags {
    self.allTags = [NSMutableArray arrayWithArray:tags];
    [self invalidateIntrinsicContentSize];
}

- (void) addTags:(NSArray <ZTTagItem *> *)tags {
    [self.allTags addObjectsFromArray:tags];
    [self invalidateIntrinsicContentSize];
}

- (void) addTag:(ZTTagItem *)tag{
    [self.allTags addObject:tag];
    [self invalidateIntrinsicContentSize];
}

- (void) removeTag:(ZTTagItem *)tag {
    if ([self.allTags containsObject:tag]) {
        [self.allTags removeObject:tag];
        [self invalidateIntrinsicContentSize];
    }
}

- (void) removeTagAtIndex:(NSInteger) tag{
    [self removeTagAtIndex:tag];
    [self invalidateIntrinsicContentSize];
}

- (void) setPreference_maxWidth:(CGFloat)preference_maxWidth {
    self.max_width = preference_maxWidth;
    [self invalidateIntrinsicContentSize];
}

- (CGSize) layoutTagButtons {
    NSInteger count = 3;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(perCountForTagView:)]) {
        count = [self.dataSource perCountForTagView:self];
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(isAutoLayoutForTagView:)]) {
        if ([self.dataSource isAutoLayoutForTagView:self]) {
          return  [self autoLayout];
        }
    } else {
        
       return [self layoutPerlineCount:count];
    }
    return [self layoutPerlineCount:count];
}

- (CGSize) autoLayout { //根据内容自动排版
    NSInteger totalCount = self.tag_buttons.count;
    CGRect buttonFrame = CGRectZero;
    NSInteger currentColumn = 0;
    NSInteger currentLine = 0; //当前行数
    CGFloat totalHeight = 0;
    CGFloat x = 5;
    for (int i = 0 ; i < totalCount ; i ++) {
        UIButton *button = self.tag_buttons[i];
        CGFloat height = button.intrinsicContentSize.height;
        if ([self.dataSource respondsToSelector:@selector(itemHeightForTagView:)]) {
            height = [self.dataSource itemHeightForTagView:self];
        }
        CGFloat width = button.titleLabel.intrinsicContentSize.width + 20 * iPhone_Rate;
        CGFloat y = ZTTagView_Margin * currentLine  + height * currentLine;
        buttonFrame = CGRectMake(x, y, width, height);
        if (CGRectGetMaxX(buttonFrame) + ZTTagView_Margin > self.max_width) {
            currentLine ++;
            currentColumn = 0;
            x = 5;
            y = ZTTagView_Margin * currentLine  + height * currentLine;
            buttonFrame = CGRectMake(x, y, width, height);
        }
        button.frame = buttonFrame;
        totalHeight = CGRectGetMaxY(buttonFrame) ;
        currentColumn ++;
        x += (ZTTagView_Margin + width);
    }
    return CGSizeMake(self.max_width, totalHeight);
}

- (CGSize) layoutPerlineCount:(NSInteger)count { //每行个数固定排版
    NSInteger totalCount = self.tag_buttons.count;
    CGFloat margin = ZTTagView_Margin;
    if ([self.dataSource respondsToSelector:@selector(tagViewMarginForTagView)]) {
        margin = [self.dataSource tagViewMarginForTagView];
    }
    CGFloat button_width = (self.max_width - (count + 1) * margin)  / (long)count;
    CGFloat totalHeight = 0;
    for (int i = 0 ; i < totalCount ; i ++) {
        NSInteger currentColumn = i % count;
        NSInteger currentLine = i / count;
        UIButton *button = self.tag_buttons[i];
//        CGFloat height = button.intrinsicContentSize.height;
        CGFloat height = 40;
        if ([self.dataSource respondsToSelector:@selector(itemHeightForTagView:)]) {
            height = [self.dataSource itemHeightForTagView:self];
        }
        CGFloat x = margin * currentColumn + margin + button_width * currentColumn ;
        CGFloat y = margin * currentLine + margin + height * currentLine;
        button.frame = CGRectMake(x, y, button_width, height);
        totalHeight = CGRectGetMaxY(button.frame) + margin;
    }
    
    return CGSizeMake(self.max_width, totalHeight);
}

#pragma mark - private
- (void) getAllButton {
    [self removeAllButtons];
    NSMutableArray *temp_buttons = [NSMutableArray array];
    UIColor *selectedBackColor = [UIColor redColor];
    UIColor *normalBackColor = [UIColor blueColor];
    UIFont *font = [UIFont systemFontOfSize:14];
    UIColor *titleColor_normal = [UIColor blackColor];
    UIColor *titleColor_selected = [UIColor blackColor];
    CGFloat cornerRadius = 0;
    CGFloat broaderWidth = 0;
    UIColor *broaderColor = nil;
    if ([self.dataSource respondsToSelector:@selector(textFontForTagView:)]) {
        font = [self.dataSource textFontForTagView:self];
    }
    if ([self.dataSource respondsToSelector:@selector(tagView:titleColorForState:)]) {
        titleColor_normal = [self.dataSource tagView:self titleColorForState:UIControlStateNormal];
        titleColor_selected = [self.dataSource tagView:self titleColorForState:UIControlStateSelected];
    }
    if ([self.dataSource respondsToSelector:@selector(cornerRadiusForTagView:)]) {
        cornerRadius = [self.dataSource cornerRadiusForTagView:self];
    }
    if ([self.dataSource respondsToSelector:@selector(broaderColorForTagView:)]) {
        broaderColor = [self.dataSource broaderColorForTagView:self];
    }
    if ([self.dataSource respondsToSelector:@selector(broaderWidthForTagView:)]) {
        broaderWidth = [self.dataSource broaderWidthForTagView:self];
    }
    
    for (ZTTagItem *item in self.allTags) {
        NSInteger index = [self.allTags indexOfObject:item];
        if ([self.dataSource respondsToSelector:@selector(broaderColorForTagView:atIndex:)]) {
            broaderColor = [self.dataSource broaderColorForTagView:self atIndex:index];
        }

        if ([self.dataSource respondsToSelector:@selector(tagView:backgroundColorForState:atIndex:)]) {
            selectedBackColor = [self.dataSource tagView:self backgroundColorForState:UIControlStateSelected atIndex:index];
            normalBackColor = [self.dataSource tagView:self backgroundColorForState:UIControlStateNormal atIndex:index];
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:item.title forState:UIControlStateNormal];
        [button setTitleColor:titleColor_normal forState:UIControlStateNormal];
        [button setTitleColor:titleColor_selected forState:UIControlStateSelected];
        if (item.isCheck) {
            button.backgroundColor = selectedBackColor;
        } else {
            button.backgroundColor = normalBackColor;
        }
        button.selected = item.isCheck;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = cornerRadius;
        button.layer.borderColor = broaderColor.CGColor;
        button.layer.borderWidth = broaderWidth;
//        button.backgroundColor = [UIColor colorWithHexString:@"0xf5f5f5"];
        [temp_buttons addObject:button];
        [button addTarget:self action:@selector(tapTagAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button.userInteractionEnabled = YES;
    }
    self.tag_buttons = temp_buttons;
}

- (void) tapTagAction:(UIButton *)button {
    NSInteger index = [self.tag_buttons indexOfObject:button];
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagView:didTapIndex:)]) {
        [self.delegate tagView:self didTapIndex:index];
    }
}

- (void) removeAllButtons {
    self.tag_buttons = nil;
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            [subView removeFromSuperview];
        }
    }
}



@end
