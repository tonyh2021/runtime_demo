//
//  MethodSwizzlingTestViewController+Tracking.m
//  runtime_demo
//
//  Created by 晓童 韩 on 16/2/24.
//  Copyright © 2016年 晓童 韩. All rights reserved.
//

#import "MethodSwizzlingTestViewController+Tracking.h"
#import <objc/runtime.h>

@implementation MethodSwizzlingTestViewController (Tracking)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(my_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling
- (void)my_viewWillAppear:(BOOL)animated {
    [self my_viewWillAppear:animated];
    NSLog(@"viewWillAppear: %@", self);
}

@end
