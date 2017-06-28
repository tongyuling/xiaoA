//
//  GetNumberPlistModel.m
//  xiaoA
//
//  Created by qianshi on 16/5/27.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "GetNumberPlistModel.h"

@implementation GetNumberPlistModel

-(id)initWithNumberPlist:(NSString *)numberPlist
{
    self = [super init];
    if (self) {
        _numberPlist = numberPlist;
    }
    return self;
}

@end
