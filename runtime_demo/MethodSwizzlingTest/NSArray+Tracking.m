//
//  NSArray+Tracking.m
//  runtime_demo
//
//  Created by 晓童 韩 on 16/2/24.
//  Copyright © 2016年 晓童 韩. All rights reserved.
//

#import "NSArray+Tracking.h"

@implementation NSArray (Tracking)

- (id)my_firstObject {
    id firstObject = [self my_firstObject];
    NSLog(@"my_firstObject");
    return firstObject;
}

@end