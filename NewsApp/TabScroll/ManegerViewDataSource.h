//
//  ManegerViewDataSource.h
//  NewsApp
//
//  Created by 陈玉乐 on 2018/6/12.
//  Copyright © 2018年 陈玉乐. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ManagerConfig;

@protocol ManegerViewDataSource <NSObject>

@optional

-(UIView *)headerView;

-(ManagerConfig *)managerConfig;

@required

-(NSInteger )numberOfPage;

-(NSString *)pageTitleAtIndex:(NSInteger)index;

-(UIViewController *)viewControllerAtIndex:(NSInteger )index;

@end
