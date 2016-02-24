//
//  ViewController.m
//  runtime_demo
//
//  Created by 晓童 韩 on 16/2/22.
//  Copyright © 2016年 晓童 韩. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "MyClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)runtimeTest1 {
    MyClass *myClass = [[MyClass alloc] init];
    unsigned int outCount = 0;
    
    Class cls = [myClass class];
    
    // 类名
    NSLog(@"-----%@-----", @"类名");
    NSLog(@"class name: %s \n", class_getName(cls));
    
    // 父类
    NSLog(@" ");
    NSLog(@"-----%@-----", @"父类");
    NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
    
    // 是否是元类
    NSLog(@" ");
    NSLog(@"-----%@-----", @"是否是元类");
    NSLog(@"MyClass is %@ a meta-class", (class_isMetaClass(cls) ? @"" : @"not"));
    
    Class meta_class = objc_getMetaClass(class_getName(cls));
    NSLog(@"%s's meta-class is %s", class_getName(cls), class_getName(meta_class));
    
    // 变量实例大小
    NSLog(@" ");
    NSLog(@"-----%@-----", @"变量实例大小");
    NSLog(@"instance size: %zu", class_getInstanceSize(cls));
    
    // 成员变量
    NSLog(@" ");
    NSLog(@"-----%@-----", @"成员变量");
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"instance variable's name: %s at index: %d", ivar_getName(ivar), i);
    }
    
    free(ivars);
    
    Ivar string = class_getInstanceVariable(cls, "_myString");
    if (string != NULL) {
        NSLog(@"instace variable %s", ivar_getName(string));
    }
    
    // 属性操作
    NSLog(@" ");
    NSLog(@"-----%@-----", @"属性操作");
    objc_property_t * properties = class_copyPropertyList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSLog(@"property's name: %s", property_getName(property));
    }
    
    free(properties);
    
    objc_property_t array = class_getProperty(cls, "array");
    if (array != NULL) {
        NSLog(@"property %s", property_getName(array));
    }
    
    
    // 方法操作
    NSLog(@" ");
    NSLog(@"-----%@-----", @"方法操作");
    Method *methods = class_copyMethodList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        NSLog(@"method's signature: %s", sel_getName(method_getName(method)));
    }
    
    free(methods);
    
    Method method1 = class_getInstanceMethod(cls, @selector(method1));
    if (method1 != NULL) {
        NSLog(@"method %s", sel_getName(method_getName(method1)));
    }
    
    Method classMethod = class_getClassMethod(cls, @selector(classMethod));
    if (classMethod != NULL) {
        NSLog(@"class method : %s", sel_getName(method_getName(classMethod)));
    }
    
    NSLog(@"MyClass is%@ responsd to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @" not");
    
    IMP imp = class_getMethodImplementation(cls, @selector(method1));
    imp();
    
    // 协议
    NSLog(@" ");
    NSLog(@"-----%@-----", @"协议");
    Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
    Protocol * protocol;
    for (int i = 0; i < outCount; i++) {
        protocol = protocols[i];
        NSLog(@"protocol name: %s", protocol_getName(protocol));
    }
    
    NSLog(@"MyClass is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));
}

- (void)runtimeTest2 {
    Class cls = objc_allocateClassPair(MyClass.class, "MySubClass", 0);
    class_addMethod(cls, @selector(submethod1), (IMP)imp_submethod1, "v@:");
    class_replaceMethod(cls, @selector(method1), (IMP)imp_submethod1, "v@:");
    class_addIvar(cls, "_ivar1", sizeof(NSString *), log(sizeof(NSString *)), "i");
    
    objc_property_attribute_t type = {"T", "@\"NSString\""};
    objc_property_attribute_t ownership = { "C", "" };
    objc_property_attribute_t backingivar = { "V", "_ivar1"};
    objc_property_attribute_t attrs[] = {type, ownership, backingivar};
    
    class_addProperty(cls, "property2", attrs, 3);
    objc_registerClassPair(cls);
    
    id instance = [[cls alloc] init];
    [instance performSelector:@selector(submethod1)];
    [instance performSelector:@selector(method1)];
}

void imp_submethod1(id self,SEL _cmd){
    NSLog(@"run sub method1:%p",_cmd);
}



@end
