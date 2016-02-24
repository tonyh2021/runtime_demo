//
//  SecondViewController.m
//  runtime_demo
//
//  Created by 晓童 韩 on 16/2/23.
//  Copyright © 2016年 晓童 韩. All rights reserved.
//

#import "SecondViewController.h"
#import <objc/runtime.h>
#import "MyClass.h"

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self runtimeTest6];
}

- (void)runtimeTest3 {
    id theObject = class_createInstance(NSString.class, sizeof(unsigned));
    id str1 = [theObject init];
    
    NSLog(@"%@", [str1 class]);
    
    id str2 = [[NSString alloc] initWithString:@"test"];
    NSLog(@"%@", [str2 class]);
}

- (void)runtimeTest4 {
    NSObject *a = [[NSObject alloc] init];
    id newB = object_copy(a, class_getInstanceSize(MyClass.class));
    object_setClass(newB, MyClass.class);
    object_dispose(a);
}

- (void)runtimeTest5 {
    int numClasses;
    Class * classes = NULL;
    
    numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0) {
        classes = malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        
        NSLog(@"number of classes: %d", numClasses);
        
        for (int i = 0; i < numClasses; i++) {
            
            Class cls = classes[i];
            NSLog(@"class name: %s", class_getName(cls));
        }
        
        free(classes);
    }
}

- (void)runtimeTest6 {
    float a[] = {1.0, 2.0, 3.0};
    NSLog(@"array encoding type: %s", @encode(typeof(a)));
}

@end
