//
//  UIScrollView+ScollerBlock.h
//  NewsApp
//
//  Created by 陈玉乐 on 2018/6/14.
//  Copyright © 2018年 陈玉乐. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScollerBlock)(UIScrollView *);

@interface UIScrollView (ScollerBlock)

@property(copy) ScollerBlock scollerBlock;

@end
