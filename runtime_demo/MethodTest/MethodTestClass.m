//
//  MethodTestClass.m
//  runtime_demo
//
//  Created by 晓童 韩 on 16/2/23.
//  Copyright © 2016年 晓童 韩. All rights reserved.
//

#import "MethodTestClass.h"
#import "MethodTestClassHelper.h"

@interface MethodTestClass()

@property (nonatomic, strong) MethodTestClassHelper *helper;

@end


@implementation MethodTestClass

#pragma mark - 备用接收者
- (instancetype)init {
    self = [super init];
    if (self != nil) {
        _helper = [[MethodTestClassHelper alloc] init];
    }
    
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    NSLog(@"forwardingTargetForSelector");
    
    NSString *selectorString = NSStringFromSelector(aSelector);
    
    // 将消息转发给_helper来处理
    if ([selectorString isEqualToString:@"helperMethod"]) {
        return _helper;
    }
    
    return [super forwardingTargetForSelector:aSelector];
}


#pragma mark - 完整消息转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    
    if (!signature) {
        if ([MethodTestClassHelper instancesRespondToSelector:aSelector]) {
            signature = [MethodTestClassHelper instanceMethodSignatureForSelector:aSelector];
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([MethodTestClassHelper instancesRespondToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:self.helper];
    }
}

@end
