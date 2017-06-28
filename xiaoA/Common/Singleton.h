//
//  Singleton.h
//  ble4.0
//
//  Created by rejoin on 15/5/18.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//
// 单利宏

// .h
#define single_interface(class) +(class *)shared##class;

// .m
#define single_implementation(class) \
static class *instance; \
+ (id)shared##class {   \
if (instance == nil) {  \
instance = [[self alloc] init]; \
}   \
return instance;    \
}   \
+ (id)allocWithZone:(struct _NSZone *)zone {    \
static dispatch_once_t onceToken;   \
dispatch_once(&onceToken, ^{    \
instance = [super allocWithZone:zone];  \
}); \
return instance;    \
}
