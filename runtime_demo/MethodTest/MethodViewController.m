//
//  MethodViewController.m
//  runtime_demo
//
//  Created by 晓童 韩 on 16/2/23.
//  Copyright © 2016年 晓童 韩. All rights reserved.
//

#import "MethodViewController.h"
#import <objc/runtime.h>
#import "MethodTestClass.h"
#import "MethodTestClassHelper.h"

@implementation MethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testMethod];
}

- (void)testMethod {
    MethodTestClass *testObj = [[MethodTestClass alloc] init];
    
    [testObj performSelector:@selector(helperMethod)];
    
    [testObj performSelector:@selector(helperMethod2)];
}


@end
