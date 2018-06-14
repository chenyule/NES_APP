//
//  ManagerConfig.h
//  NewsApp
//
//  Created by 陈玉乐 on 2018/6/12.
//  Copyright © 2018年 陈玉乐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ManagerConfig : NSObject

/**
 选项卡高度
 */
@property(copy,nonatomic) NSNumber *tabHeight;

/**
 选项卡背景颜色
 */
@property(copy,nonatomic) UIColor *tabBackGroundColor;



/**
 普通标题颜色
 */
@property(copy,nonatomic) UIColor *normalTitleColor;

/**
 选中标题颜色
 */
@property(copy,nonatomic) UIColor *selectTitleColor;

/**
 标题字体大小
 */
@property(copy,nonatomic) UIFont * titleFont;

/**
 选中时是否放大字体
 */
@property(copy,nonatomic) NSNumber* isScale;

/**
 放大倍数
 */
@property(copy,nonatomic) NSNumber* scaleSize;

/**
 左右间距
 */
@property(copy,nonatomic) NSNumber* margin;

/**
 选项按钮的间距
 */
@property(copy,nonatomic) NSNumber *itemMargin;

/**
 按钮是否平分
 */
@property(copy,nonatomic) NSNumber *isAverage;

/**
 滑块颜色
 */
@property(copy,nonatomic) UIColor *sliderColor;

/**
 滑块高度(设置为@0 可隐藏)
 */
@property(copy,nonatomic) NSNumber *sliderHeight;

/**
 滑块宽度(不设置 将会自动计算为按钮的文字大小，设置后以设置为准)
 */
@property(copy,nonatomic) NSNumber *sliderWidth;

/**
 滑动过程颜色是否渐变
 */
@property(copy,nonatomic) NSNumber *isColorAnimation;


/**
 是否隐藏底分隔线
 */
@property(copy,nonatomic) NSNumber *isHideBottomLine;

/**
 分隔线高度
 */
@property(copy,nonatomic) NSNumber *bottomLineHeight;

/**
 分隔线颜色
 */
@property(copy,nonatomic) UIColor  *bottomLineColor;



@end
