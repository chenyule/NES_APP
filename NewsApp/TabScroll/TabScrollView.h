//
//  TabScrollView.h
//  NewsApp
//
//  Created by 陈玉乐 on 2018/6/12.
//  Copyright © 2018年 陈玉乐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManegerViewDataSource.h"

@interface TabScrollView : UIScrollView

@property(assign,readonly) NSInteger currentPage;

@property(copy,nonatomic) void(^contentScollerDidScroll)(UIScrollView *);

-(void)addViewContrllerAtIndex:(NSInteger )index;

-(instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)controller manegerViewDataSource:(id <ManegerViewDataSource>)dataSource topOffsety:(CGFloat )offset;

@end
