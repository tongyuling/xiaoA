//
//  GuideModel.m
//  xiaoA
//
//  Created by qianshi on 16/5/23.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "GuideModel.h"

@implementation GuideModel

-(id)initWithJingDu:(NSString *)jingDu weiDu:(NSString *)weiDu address:(NSString *)address
{
    self = [super init];
    if (self) {
        _jingDu = jingDu;
        _weiDu = weiDu;
        _address = address;
    }
    return self;
}

@end
