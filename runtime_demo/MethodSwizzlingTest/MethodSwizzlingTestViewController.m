//
//  MethodSwizzlingTestViewController.m
//  runtime_demo
//
//  Created by 晓童 韩 on 16/2/23.
//  Copyright © 2016年 晓童 韩. All rights reserved.
//

#import "MethodSwizzlingTestViewController.h"
#import "MethodSwizzlingTestViewController+Tracking.h"
#import "NSArray+Tracking.h"
#import <objc/runtime.h>

@implementation MethodSwizzlingTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testMethodSwizzling];
}

- (void)testMethodSwizzling {
    //调换IMP
    Method old_Method =  class_getInstanceMethod([NSArray class], @selector(firstObject));
    Method my_Method = class_getInstanceMethod([NSArray class], @selector(my_firstObject));
    method_exchangeImplementations(old_Method, my_Method);
    
    NSArray *array = @[@"a",@"b",@"c",@"d"];
    NSString *string = [array firstObject];
    NSLog(@"firstObject: %@", string);
}

@end
