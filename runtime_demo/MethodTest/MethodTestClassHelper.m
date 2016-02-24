//
//  MethodTestClassHelper.m
//  runtime_demo
//
//  Created by 晓童 韩 on 16/2/23.
//  Copyright © 2016年 晓童 韩. All rights reserved.
//

#import "MethodTestClassHelper.h"

@implementation MethodTestClassHelper

- (void)helperMethod {
    NSLog(@"helperMethod : %@, %p", self, _cmd);
}

- (void)helperMethod2 {
    NSLog(@"helperMethod2 : %@, %p", self, _cmd);
}

@end
