//
//  ManegerView.m
//  NewsApp
//
//  Created by 陈玉乐 on 2018/6/12.
//  Copyright © 2018年 陈玉乐. All rights reserved.
//

#import "ManegerView.h"
#import "TabManger.h"
#import "ManagerConfig.h"




@interface ManegerView ()

@property(weak,nonatomic) id <ManegerViewDataSource> dataSource;

@property(weak,nonatomic) UIViewController *currentViewController;

@property(assign ,nonatomic) CGFloat headerHeight;

@property(strong,nonatomic) UIView*headerView;

@property(strong,nonatomic) ManagerConfig *managerConfig;

@property(strong,nonatomic) TabManger *tabManger;


@end


@implementation ManegerView


-(instancetype)initWithFrame:(CGRect)frame currentViewController:(UIViewController *)viewController manegerViewDataSource:(id<ManegerViewDataSource>)dataSource{
    

    if (self = [super initWithFrame:frame]) {
        
        _currentViewController = viewController;
        _dataSource = dataSource;
    }
    
    return self;
}


-(void)loadViews{
    
    if (!_dataSource) {
        
        return;
    }
    
    if ([self.dataSource numberOfPage] == 0) {
        return;
    }
    
    if ([self.dataSource respondsToSelector:@selector(headerView)]) {
        
        _headerView = [self.dataSource headerView];
    }
    
    if ([self.dataSource respondsToSelector:@selector(managerConfig)]) {
        
        _managerConfig = [self.dataSource  managerConfig];
    }
    
    if (!_managerConfig) {
        
        _managerConfig = [ManagerConfig new];
    }

    [self addContentView];
}


-(void)addContentView{
    
     _headerHeight = 0.0;
    if (_headerView) {
        _headerHeight = CGRectGetHeight(_headerView.frame);
        [self addSubview:_headerView];
    }
    
    
    CGRect rect = self.bounds;
    rect.origin.y = _headerHeight;
    
    _tabManger = [[TabManger alloc] initWithFrame:rect viewController:_currentViewController managerConfig:_managerConfig manegerViewDataSource:_dataSource];
    
    
    __weak typeof(self) weakSelf = self;

    _tabManger.contentScollerDidScroll = ^(UIScrollView *src) {

        
        CGFloat offset = -1 *weakSelf.managerConfig.tabHeight.floatValue;
        
        if (src.contentOffset.y > offset && !CGRectEqualToRect(weakSelf.tabManger.frame, weakSelf.bounds) ) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                weakSelf.tabManger.frame = weakSelf.bounds;
            }];

        }else if (src.contentOffset.y < offset && !CGRectEqualToRect(weakSelf.tabManger.frame, rect)){

            
            [UIView animateWithDuration:0.3 animations:^{
                
                weakSelf.tabManger.frame = rect;
            }];
        }
    };
    
    [self addSubview: _tabManger];
}


@end
