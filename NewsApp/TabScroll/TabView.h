//
//  TabView.h
//  NewsApp
//
//  Created by 陈玉乐 on 2018/6/12.
//  Copyright © 2018年 陈玉乐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManegerViewDataSource.h"
#import "ManagerConfig.h"

@interface TabView : UIView

@property(copy) void(^tapSelect)(NSInteger);

@property(assign,nonatomic) NSInteger currentIndex;

-(instancetype)initWithFrame:(CGRect)frame managerConfig:(ManagerConfig*)managerConfig dataSource:(id <ManegerViewDataSource>)dataSource;

-(void)changeSelectForm:(NSInteger )from toIndex:(NSInteger )to progress:(CGFloat )progress;

-(void)scrollButtonToCenterAtIndex:(NSInteger )index;

@end
