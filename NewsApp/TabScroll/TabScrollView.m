//
//  TabScrollView.m
//  NewsApp
//
//  Created by 陈玉乐 on 2018/6/12.
//  Copyright © 2018年 陈玉乐. All rights reserved.
//

#import "TabScrollView.h"
#import "UIViewController+ScrollerView.h"
#import "UIScrollView+ScollerBlock.h"

@interface TabScrollView ()<UIScrollViewDelegate>

@property(weak,nonatomic) UIViewController *controller;
@property(weak,nonatomic) id <ManegerViewDataSource> dataSource;

@end

@implementation TabScrollView

-(instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)controller manegerViewDataSource:(id<ManegerViewDataSource>)dataSource{
    
    if (self = [super initWithFrame:frame]) {
        
        _controller = controller;
        _dataSource = dataSource;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        
        [self loadView];
    }
    
    return self;
}


-(void)loadView{
    
    if (!_dataSource) {
        
        return;
    }
    
    NSInteger page = [self.dataSource numberOfPage];
    
    if (page == 0) {
        
        return;
    }
    
    [self setContentSize:CGSizeMake(page*self.frame.size.width, self.frame.size.height)];
    
    [self addViewContrllerAtIndex:0];
}



-(void)addViewContrllerAtIndex:(NSInteger )index{
    
    UIViewController *vieController = [self.dataSource viewControllerAtIndex:index];
    
    if ([self.controller.childViewControllers containsObject:vieController]) {
        
        return;
    }
    
    [self.controller addChildViewController:vieController];
    
    vieController.view.frame = CGRectMake(index*CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    [self addSubview:vieController.view];
    
    __weak typeof(self) weakSelf = self;
    vieController.contentScrollView.scollerBlock = ^(UIScrollView *src) {
        
        if (weakSelf.contentScollerDidScroll) {
            
            weakSelf.contentScollerDidScroll(src);
        }
    };
}


-(NSInteger )currentPage{
    
    if (self.bounds.size.width == 0 || self.bounds.size.height == 0) {
        return 0;
    }
    NSInteger index =  (self.contentOffset.x + self.bounds.size.width * 0.5) / self.bounds.size.width;
    
    return MAX(0,index);
    
}


@end
