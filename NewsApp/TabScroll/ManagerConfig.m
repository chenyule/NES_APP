//
//  ManagerConfig.m
//  NewsApp
//
//  Created by 陈玉乐 on 2018/6/12.
//  Copyright © 2018年 陈玉乐. All rights reserved.
//

#import "ManagerConfig.h"

@implementation ManagerConfig



-(NSNumber *)tabHeight{
    
    if (!_tabHeight) {
        
        _tabHeight = @44.0;
    }
    
    return _tabHeight;
}


-(UIColor *)tabBackGroundColor{
    
    if (!_tabBackGroundColor) {
        
        _tabBackGroundColor = [UIColor colorWithRed:255/255.0 green:239/255.0 blue:213/255.0 alpha:1.0];
    }
    
    return _tabBackGroundColor;
}


-(UIColor *)normalTitleColor{
    
    if (!_normalTitleColor) {
        
        _normalTitleColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    }
    
    return _normalTitleColor;
}

-(UIColor *)selectTitleColor{
    
    if (!_selectTitleColor) {
        
        _selectTitleColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    }
    
    return _selectTitleColor;
}

-(UIFont *)titleFont{
    
    if (!_titleFont) {
        
        _titleFont = [UIFont systemFontOfSize:16.0];
    }
    
    return _titleFont;
}

-(NSNumber *)isScale{
    
    if (!_isScale) {
        
        _isScale = @YES;
    }
    
    return _isScale;
}

-(NSNumber *)scaleSize{
    
    if (!_scaleSize) {
        
        _scaleSize = @1.2;
    }
    return _scaleSize;
}


-(NSNumber *)margin{
    
    if (!_margin) {
        
        _margin = @10;
    }
    return _margin;
}

-(NSNumber *)itemMargin{
    
    if (!_itemMargin) {
        
        _itemMargin = @30;
    }
    
    return _itemMargin;
}

-(NSNumber *)isAverage{
    
    if (!_isAverage) {
        
        _isAverage = @NO;
    }
    
    return _isAverage;
    
}

-(UIColor *)sliderColor{
    
    if (!_sliderColor) {
        
        _sliderColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    }
    
    return _sliderColor;
}

-(NSNumber *)sliderHeight{
    
    if (!_sliderHeight) {
        
        _sliderHeight = @2.0;
    }
    
    return _sliderHeight;
}


-(NSNumber *)isColorAnimation{
    
    if (!_isColorAnimation) {
        
        _isColorAnimation = @YES;
    }
    
    return _isColorAnimation;
}


-(NSNumber *)isHideBottomLine{
    
    if (!_isHideBottomLine) {
        
        _isHideBottomLine = @NO;
    }
    
    return _isHideBottomLine;
}

-(NSNumber *)bottomLineHeight{
    
    if (!_bottomLineHeight) {
        
        _bottomLineHeight = @0.5;
    }
    
    return _bottomLineHeight;
}

-(UIColor *)bottomLineColor{
    
    if (!_bottomLineColor) {
        
        _bottomLineColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    }
    
    return _bottomLineColor;
}


@end
