//
//  UIScrollView+ScollerBlock.m
//  NewsApp
//
//  Created by 陈玉乐 on 2018/6/14.
//  Copyright © 2018年 陈玉乐. All rights reserved.
//

#import "UIScrollView+ScollerBlock.h"
#import <objc/runtime.h>

@implementation UIScrollView (ScollerBlock)

-(void)setScollerBlock:(ScollerBlock)scollerBlock{
    
    objc_setAssociatedObject(self, @selector(scollerBlock), scollerBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

-(ScollerBlock )scollerBlock{
    

    return objc_getAssociatedObject(self, _cmd);
    
}

+(void)load{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        SEL orignalSelect = NSSelectorFromString(@"_notifyDidScroll");
        SEL replaceSelect = @selector(block_scrollViewDidScroll);
        
        Method orignalMethod = class_getInstanceMethod(self, orignalSelect);
        Method replaceMethod = class_getInstanceMethod(self, replaceSelect);
        
        
        BOOL isSuccess = class_addMethod(self, orignalSelect, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod));
        
        if (isSuccess) {
            
            class_replaceMethod(self, replaceSelect, method_getImplementation(orignalMethod), method_getTypeEncoding(orignalMethod));
        }else{
            
            method_exchangeImplementations(orignalMethod, replaceMethod);
        }
        
    });
    
}

-(void)block_scrollViewDidScroll{
    
    [self block_scrollViewDidScroll];
    
    if (self.scollerBlock) {
        
        self.scollerBlock(self);
    }

}


@end
