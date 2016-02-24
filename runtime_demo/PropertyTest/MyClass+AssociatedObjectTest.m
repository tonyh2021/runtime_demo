//
//  MyClass+AssociatedObjectTest.m
//  runtime_demo
//
//  Created by 晓童 韩 on 16/2/23.
//  Copyright © 2016年 晓童 韩. All rights reserved.
//

#import "MyClass+AssociatedObjectTest.h"
#import <objc/runtime.h>

@implementation MyClass (AssociatedObjectTest)

static char MyClassKey;

- (void)setProperty:(NSString *)property {
    [self willChangeValueForKey:@"MyClassKey"];
    objc_setAssociatedObject(self, &MyClassKey,
                             property,
                             OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"MyClassKey"];
}

- (NSString *)property {
    return objc_getAssociatedObject(self, &MyClassKey);
}

@end
