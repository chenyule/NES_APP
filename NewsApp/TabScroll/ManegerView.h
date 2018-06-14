//
//  ManegerView.h
//  NewsApp
//
//  Created by 陈玉乐 on 2018/6/12.
//  Copyright © 2018年 陈玉乐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManegerViewDataSource.h"

@interface ManegerView : UIView


-(instancetype)initWithFrame:(CGRect)frame
       currentViewController:(UIViewController *)viewController
       manegerViewDataSource:(id <ManegerViewDataSource>)dataSource;

-(void)loadViews;

@end

