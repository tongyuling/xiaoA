//
//  LoginTool.m
//  xiaoA
//
//  Created by qianshi on 16/5/25.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "LoginTool.h"
#import "LoginModel.h"

@implementation LoginTool

single_implementation(LoginTool)

#pragma mark 保存
- (void)saveLoginModel:(LoginModel *)loginModel
{
    [[NSUserDefaults standardUserDefaults]setObject:loginModel.loginName forKey:@"loginName"];
    [[NSUserDefaults standardUserDefaults]setObject:loginModel.loginImage forKey:@"loginImage"];
    //同步
    [[NSUserDefaults standardUserDefaults] synchronize];
}



#pragma mark 访问
- (LoginModel *)loginModel
{
    LoginModel * loginModel = [[LoginModel alloc]init];
    loginModel.loginName = [[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"];
    loginModel.loginImage = [[NSUserDefaults standardUserDefaults] stringForKey:@"loginImage"];

    return loginModel;
}


@end
