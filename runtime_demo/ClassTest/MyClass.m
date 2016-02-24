//
//  MyClass.m
//  runtime_demo
//
//  Created by 晓童 韩 on 16/2/22.
//  Copyright © 2016年 晓童 韩. All rights reserved.
//

#import "MyClass.h"

@interface MyClass () {
    NSInteger       _instance1;
    
    NSString *_instance2;
}

@property (nonatomic, assign) NSUInteger integer;

- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2;

@end

@implementation MyClass
+ (void)classMethod {

}

- (void)method1 {
    NSLog(@"call method method1");
}

- (void)method2 {
}

- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2 {
    NSLog(@"arg1 : %ld, arg2 : %@", arg1, arg2);
}
@end
