//
//  LoginModel.m
//  xiaoA
//
//  Created by qianshi on 16/5/25.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

-(id)initWithLoginName:(NSString *)loginName loginImage:(NSString *)loginImage
{
    self = [super init];
    if (self) {
        _loginName = loginName;
        _loginImage = loginImage;
    }
    return self;
}

@end
