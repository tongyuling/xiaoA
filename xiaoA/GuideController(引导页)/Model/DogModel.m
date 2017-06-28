//
//  DogModel.m
//  xiaoA
//
//  Created by qianshi on 16/5/25.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "DogModel.h"

@implementation DogModel

-(id)initWithDogName:(NSString *)dogName dogAge:(NSString *)dogAge dogVariety:(NSString *)dogVariety dogSex:(NSString *)dogSex dogMessage:(NSString *)dogMessage
{
    self = [super init];
    if (self) {
        _dogName = dogName;
        _dogAge = dogAge;
        _dogVariety = dogVariety;
        _dogSex = dogSex;
        _dogMessage = dogMessage;
    }
    return self;
}

@end
