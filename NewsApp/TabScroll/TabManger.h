//
//  TabManger.h
//  NewsApp
//
//  Created by 陈玉乐 on 2018/6/12.
//  Copyright © 2018年 陈玉乐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManegerViewDataSource.h"
@class ManagerConfig;

@interface TabManger : UIView

@property(copy,nonatomic) void(^contentScollerDidScroll)(UIScrollView *);


-(instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController managerConfig:(ManagerConfig*)managerConfig manegerViewDataSource:(id <ManegerViewDataSource >)manegerViewDataSource;


@end
