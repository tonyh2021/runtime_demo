//
//  PropertyViewController.m
//  runtime_demo
//
//  Created by 晓童 韩 on 16/2/23.
//  Copyright © 2016年 晓童 韩. All rights reserved.
//

#import "PropertyViewController.h"
#import <objc/runtime.h>
#import "MyClass+AssociatedObjectTest.h"
#import "NSObject+Extension.h"
#import "Student.h"

static char kDTActionHandlerTapGestureKey;
static char kDTActionHandlerTapBlockKey;

@implementation PropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTapActionWithBlock:^{
        NSLog(@"Tap! Tap!");
    }];
    
    //    [self testAssociatedObject];
    
    [self testSEL];
}

- (void)setTapActionWithBlock:(void (^)(void))block {
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
        [self.view addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        
        if (action) {
            action();
        }
    }
}

- (void)testAssociatedObject {
    MyClass *myObj = [[MyClass alloc] init];
    myObj.property = @"Hi! AssociatedObject!";
    NSLog(@"myObj的属性property值为：%@", myObj.property);
}

- (void)dict2Object {
    Student *stu = [Student objectWithDict:@{@"name" : @"Tom", @"address" : @"Beijing"}];
    NSLog(@"stu的name值为: %@, address为: %@" , stu.name, stu.address);
}

- (void)testSEL {
    SEL sel1 = @selector(method1);
    NSLog(@"sel : %p", sel1);
}


@end
