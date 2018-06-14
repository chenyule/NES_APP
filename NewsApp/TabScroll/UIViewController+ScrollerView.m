//
//  UIViewController+ScrollerView.m
//  NewsApp
//
//  Created by 陈玉乐 on 2018/6/14.
//  Copyright © 2018年 陈玉乐. All rights reserved.
//

#import "UIViewController+ScrollerView.h"
#import <objc/runtime.h>

@implementation UIViewController (ScrollerView)

-(void)setContentScrollView:(UIScrollView *)contentScrollView{
    
    objc_setAssociatedObject(self, @selector(contentScrollView), contentScrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(UIScrollView *)contentScrollView{
    
    
    return objc_getAssociatedObject(self, _cmd);
}

@end
