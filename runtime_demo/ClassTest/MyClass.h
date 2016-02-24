//
//  MyClass.h
//  runtime_demo
//
//  Created by 晓童 韩 on 16/2/22.
//  Copyright © 2016年 晓童 韩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject <NSCopying, NSCoding>

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, copy) NSString *myString;

- (void)method1;

- (void)method2;

+ (void)classMethod;

@end
