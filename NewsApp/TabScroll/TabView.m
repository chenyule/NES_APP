//
//  TabView.m
//  NewsApp
//
//  Created by 陈玉乐 on 2018/6/12.
//  Copyright © 2018年 陈玉乐. All rights reserved.
//

#import "TabView.h"

@interface TabView()

@property(weak,nonatomic) id <ManegerViewDataSource >dataSource;
@property(strong,nonatomic) ManagerConfig *managerConfig;

@property(strong,nonatomic) UIScrollView *contentView;
@property(strong,nonatomic) UIView *slierView;
@property(strong,nonatomic) UIView *bottomlineView;

@property(strong,nonatomic) NSMutableArray *buttonArray;
@property(strong,nonatomic) NSMutableArray *titleWidthArray;
@property(strong,nonatomic) NSMutableArray *lineWidthArray;





@end

@implementation TabView

-(instancetype)initWithFrame:(CGRect)frame managerConfig:(ManagerConfig*)managerConfig dataSource:(id <ManegerViewDataSource>)dataSource{
    
    
    if (self = [super initWithFrame:frame]) {
        
        _dataSource = dataSource;
        _managerConfig = managerConfig;
        
        [self loadView];
    }
    
    return self;
    
}


-(void)loadView{
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.slierView];
    
    if (self.managerConfig.isHideBottomLine.boolValue == NO) {
        
        [self.contentView addSubview:self.bottomlineView];
    }
    
    self.currentIndex = 0;
    
    [self buttonLayout];
}

-(void)buttonLayout{
    
    NSInteger pageCount = [self.dataSource numberOfPage];
    if(pageCount == 0) return;
    NSInteger currentIndex = 0;
    
    CGFloat startX = self.managerConfig.margin.floatValue;
    CGFloat startY = 0;
    CGFloat buttonH = CGRectGetHeight(_contentView.frame)- CGRectGetHeight(_slierView.frame) - (self.managerConfig.isHideBottomLine.boolValue ? 0 : self.managerConfig.bottomLineHeight.floatValue);
    do {
        
        //如果是均分 求出每个按钮的宽度
        if (self.managerConfig.isAverage.boolValue) {
            
            CGFloat averageWidth = (CGRectGetWidth(_contentView.frame) - self.managerConfig.margin.floatValue * 2.0 - (pageCount-1)*self.managerConfig.itemMargin.floatValue)/pageCount;
            
            [self.titleWidthArray addObject:@(averageWidth)];
            [self.lineWidthArray addObject:self.managerConfig.sliderWidth ? self.managerConfig.sliderWidth : @(averageWidth)];
            
        }
        
        NSString *title = [self.dataSource pageTitleAtIndex:currentIndex];
        CGFloat textWith = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.managerConfig.titleFont} context:nil].size.width;
        //如果不是均分 按钮的宽度
        if (self.managerConfig.isAverage.boolValue == NO) {
            
            [self.titleWidthArray addObject:@(textWith)];
            [self.lineWidthArray addObject:self.managerConfig.sliderWidth ? self.managerConfig.sliderWidth : @(textWith)];
        }
        
        
        
        
        CGFloat buttonWith = [self.titleWidthArray[currentIndex] floatValue];
        
        UIButton *button = [self tabButtonFrame:CGRectMake(startX, startY, buttonWith, buttonH) tag:currentIndex title:title parentView:_contentView];
        [self.buttonArray addObject:button];
        
        startX = CGRectGetMaxX(button.frame) + self.managerConfig.itemMargin.floatValue;
        
    } while (++currentIndex < pageCount);
    
    
    //设置第一个按钮的状态以及滑块的初始位置
    UIButton *button = self.buttonArray.firstObject;
    [button setTitleColor:self.managerConfig.selectTitleColor forState:UIControlStateNormal];
    
    if (self.managerConfig.isScale.boolValue) {
        
        button.transform = CGAffineTransformMakeScale(self.managerConfig.scaleSize.floatValue, self.managerConfig.scaleSize.floatValue);
        
    }
    
    CGFloat sliderWdith = [self.lineWidthArray.firstObject floatValue];
    CGFloat adjsutX = (CGRectGetWidth(button.frame) - sliderWdith)/2.0;
    
    CGRect orignalRect = self.slierView.frame;
    orignalRect.origin.x = CGRectGetMinX(button.frame) +  adjsutX;
    orignalRect.size.width = sliderWdith;
    self.slierView.frame = orignalRect;
    
    
    UIButton *lastButton = self.buttonArray.lastObject;
    
    [_contentView setContentSize:CGSizeMake(CGRectGetMaxX(lastButton.frame) + self.managerConfig.margin.floatValue, 0)];
    
}

-(void)selectButton:(UIButton *)button{
    
    UIButton *origButton = self.buttonArray[_currentIndex];
    [origButton setTitleColor:self.managerConfig.normalTitleColor forState:UIControlStateNormal];
    
    [button setTitleColor:self.managerConfig.selectTitleColor forState:UIControlStateNormal];
    CGFloat sliderWdith = [self.lineWidthArray[button.tag] floatValue];
    CGFloat adjsutX = (CGRectGetWidth(button.frame) - sliderWdith)/2.0;
    CGRect orignalRect = self.slierView.frame;
    orignalRect.origin.x = CGRectGetMinX(button.frame) +  adjsutX;
    orignalRect.size.width = sliderWdith;
   
    
    [UIView animateWithDuration:.3 animations:^{
        
        if (self.managerConfig.isScale.boolValue) {

            origButton.transform = CGAffineTransformIdentity;
            button.transform = CGAffineTransformMakeScale(self.managerConfig.scaleSize.floatValue, self.managerConfig.scaleSize.floatValue);
        }
        
         self.slierView.frame = orignalRect;
    }];
    
    [self scrollButtonToCenterAtIndex:button.tag];
    //选中按钮滚动到中心
    _currentIndex = button.tag;
    
    if (self.tapSelect) {
        
        self.tapSelect(button.tag);
    }
}

-(void)scrollButtonToCenterAtIndex:(NSInteger )index{
    
    UIButton * button = self.buttonArray[index];
    CGFloat buttonCenterx = button.center.x;
    CGFloat scrollx = buttonCenterx - 0.5*CGRectGetWidth(_contentView.frame);
    
    if (scrollx > _contentView.contentSize.width - CGRectGetWidth(_contentView.frame)) {
        
        scrollx = _contentView.contentSize.width - CGRectGetWidth(_contentView.frame);
    }
    
    if (scrollx <= 0) {
        
        scrollx = 0;
    }
    
    [_contentView setContentOffset:CGPointMake(scrollx, 0) animated:YES];
    
}

-(UIButton *)tabButtonFrame:(CGRect )frame tag:(NSInteger )tag title:(NSString *)title parentView:(UIView *)parentView{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = tag;
    [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:self.managerConfig.normalTitleColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:self.managerConfig.titleFont];
    [parentView addSubview:button];
    
    return button;
}


-(void)changeSelectForm:(NSInteger)from toIndex:(NSInteger)to progress:(CGFloat)progress{
    
    UIButton *fromButton = self.buttonArray[from];
    UIButton *toButton  = self.buttonArray[to];
    
    if (self.managerConfig.isScale.boolValue) {
        
        CGFloat scale = (self.managerConfig.scaleSize.floatValue - 1) *progress;
        fromButton.transform = CGAffineTransformMakeScale(self.managerConfig.scaleSize.floatValue - scale, self.managerConfig.scaleSize.floatValue - scale);
        toButton.transform = CGAffineTransformMakeScale(1 + scale, 1 + scale);
        
    }
    
    
    CGFloat currentLineWidth = [self.lineWidthArray[from] floatValue];
    CGFloat nextLineWidth = [self.lineWidthArray[to] floatValue];
    
    CGFloat currentX = fromButton.center.x - 0.5*currentLineWidth;
    CGFloat nextX  = toButton.center.x - 0.5*nextLineWidth;
    
    
    CGFloat adjustX = nextX - currentX;
    CGFloat adjsustWidth = nextLineWidth - currentLineWidth;
    
    CGRect currentReact = self.slierView.frame;
    currentReact.origin.x = currentX + progress*adjustX;
    currentReact.size.width = currentLineWidth + progress*adjsustWidth;
    
    self.slierView.frame = currentReact;
    
    if (self.managerConfig.isColorAnimation.boolValue) {
        
        [fromButton setTitleColor:[self colorWithFrom:self.managerConfig.selectTitleColor toColor:self.managerConfig.normalTitleColor progress:progress] forState:UIControlStateNormal];
        [toButton  setTitleColor:[self colorWithFrom:self.managerConfig.normalTitleColor toColor:self.managerConfig.selectTitleColor progress:progress] forState:UIControlStateNormal];
    }
    
}


-(UIColor *)colorWithFrom:(UIColor *)form toColor:(UIColor *)to progress:(CGFloat )progress{
    
    CGFloat fromR =0, fromG = 0, fromB =0 ,fromA = 0;
    
    [form getRed:&fromR green:&fromG blue:&fromB alpha:&fromA];
    
    CGFloat toR =0, toG = 0, toB =0 ,toA = 0;
    
    [to getRed:&toR green:&toG blue:&toB alpha:&toA];
    
    return [UIColor colorWithRed:fromR+(toR-fromR)*progress green:fromG+(toG-fromG)*progress blue:fromB+(toB-fromB)*progress alpha:fromA+(toA-fromA)*progress];
}

-(UIScrollView *)contentView{
    
    if (!_contentView) {
        
        _contentView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _contentView.backgroundColor = self.managerConfig.tabBackGroundColor;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.bounces = NO;
    }
    return _contentView;
}

-(UIView *)slierView{
    
    if (!_slierView) {
        
        CGFloat bottomLineHeight = self.managerConfig.isHideBottomLine.boolValue ? 0 : self.managerConfig.bottomLineHeight.floatValue;
        
        _slierView = [[UIView alloc] initWithFrame:CGRectMake(self.managerConfig.margin.floatValue, self.contentView.frame.size.height - self.managerConfig.sliderHeight.floatValue - bottomLineHeight, 0, self.managerConfig.sliderHeight.floatValue)];
        _slierView.backgroundColor = self.managerConfig.sliderColor;
    }
    
    return _slierView;
}

-(UIView *)bottomlineView{
    
    if (!_bottomlineView) {
        
        _bottomlineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - self.managerConfig.bottomLineHeight.floatValue, self.contentView.frame.size.width, self.managerConfig.bottomLineHeight.floatValue)];
        _bottomlineView.backgroundColor = self.managerConfig.bottomLineColor;
    }
    
    return _bottomlineView;
    
}

-(NSMutableArray *)buttonArray{
    
    if (!_buttonArray) {
        
        _buttonArray = [[NSMutableArray alloc] init];
    }
    
    return _buttonArray;
}

-(NSMutableArray *)titleWidthArray{
    
    if (!_titleWidthArray) {
        
        _titleWidthArray = [[NSMutableArray alloc] init];
    
    }
    
    return _titleWidthArray;
}

-(NSMutableArray *)lineWidthArray{
    
    if (!_lineWidthArray) {
        
        _lineWidthArray = [[NSMutableArray alloc] init];
    }
    
    return _lineWidthArray;
}

@end
