//
//  TabManger.m
//  NewsApp
//
//  Created by 陈玉乐 on 2018/6/12.
//  Copyright © 2018年 陈玉乐. All rights reserved.
//

#import "TabManger.h"
#import "TabView.h"
#import "TabScrollView.h"

@interface TabManger ()<UIScrollViewDelegate>


@property(weak,nonatomic) id <ManegerViewDataSource> dataSource;

@property(assign,nonatomic) BOOL isClick;


@property(strong,nonatomic) TabView *tabView;
@property(strong,nonatomic) TabScrollView *tabScrollView;
@property(assign,nonatomic) CGFloat startx;

@end


@implementation TabManger

-(instancetype)initWithFrame:(CGRect)frame
              viewController:(UIViewController *)viewController
               managerConfig:(ManagerConfig*)managerConfig
       manegerViewDataSource:(id <ManegerViewDataSource >)manegerViewDataSource{
    
    if (self = [super initWithFrame:frame]) {
       
        self.backgroundColor = [UIColor whiteColor];
        
        CGRect rect = CGRectMake(0, 0, self.bounds.size.width, managerConfig.tabHeight.floatValue);
        _tabView = [[TabView alloc] initWithFrame:rect managerConfig:managerConfig dataSource:manegerViewDataSource];
        _tabScrollView = [[TabScrollView alloc] initWithFrame:self.bounds viewController:viewController manegerViewDataSource:manegerViewDataSource topOffsety:managerConfig.tabHeight.floatValue];
        _tabScrollView.delegate = self;
        
        [self addSubview:_tabScrollView];
        [self addSubview:_tabView];
        
        __weak typeof(self) weakSelf = self;
        _tabView.tapSelect = ^(NSInteger page) {
            weakSelf.isClick = YES;
            [weakSelf.tabScrollView setContentOffset:CGPointMake(page* weakSelf.tabScrollView.frame.size.width, 0)];
            weakSelf.isClick = NO;
        };
    }
    
    return self;
    
}

-(void)setContentScollerDidScroll:(void (^)(UIScrollView *))contentScollerDidScroll{

    _tabScrollView.contentScollerDidScroll = contentScollerDidScroll;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetx = scrollView.contentOffset.x;
    [self scrollViewDidScrollOffsetx:offsetx];

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    self.startx = scrollView.contentOffset.x;
}

-(void)scrollViewDidScrollOffsetx:(CGFloat )offx{
 
    [self changeLineOffsetx:offx];
    
    NSInteger currentScrollPage = self.tabScrollView.currentPage;
    
    if (currentScrollPage != self.tabView.currentIndex) {
    
        [self.tabView scrollButtonToCenterAtIndex:currentScrollPage];
        
        self.tabView.currentIndex = currentScrollPage;
    }
    
    [self.tabScrollView addViewContrllerAtIndex:currentScrollPage];
    
}

-(void)changeLineOffsetx:(CGFloat )offx{
    
    if (self.isClick) {
        
        return;
    }
    
    CGFloat curentOffSetx = offx;
    
    CGFloat width = self.tabScrollView.frame.size.width;
    CGFloat maxOffset  = self.tabScrollView.contentSize.width - width;
    
    if (curentOffSetx >= maxOffset) {
        
        curentOffSetx = maxOffset - 0.5;//防止越界
    }
    
    if (curentOffSetx <= 0) {
        
        curentOffSetx = 0.5;//防止越界
        
    }
    
    int nextindex = curentOffSetx/width;
    int sourIndex = curentOffSetx/width;
    
    CGFloat progress = curentOffSetx/width - floor(curentOffSetx/width);
    
    //左滑动
    if (curentOffSetx > self.startx) {
        
        nextindex  += 1;
    }else{
        
        sourIndex += 1;
        
        progress = 1 - progress;
    }
    
    [self.tabView changeSelectForm:sourIndex toIndex:nextindex progress:progress];
}

@end
