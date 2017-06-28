//
//  LoginTool.h
//  xiaoA
//
//  Created by qianshi on 16/5/25.
//  Copyright © 2016年 chenlingang. All rights reserved.
//
// 保存登录人信息

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "LoginModel.h"

@class LoginModel;
@interface LoginTool : NSObject

single_interface(LoginTool)

/**
 * 保存用户
 **/
- (void)saveLoginModel:(LoginModel *)loginModel;

/**
 * 访问用户
 **/
@property (nonatomic, strong, readonly) LoginModel *loginModel;




@end
