//
//  GetNumberPlistTool.m
//  xiaoA
//
//  Created by qianshi on 16/5/27.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "GetNumberPlistTool.h"
#import "GetNumberPlistModel.h"

@implementation GetNumberPlistTool

single_implementation(GetNumberPlistTool)

#pragma mark 保存
- (void)saveGetNumberPlistModel:(GetNumberPlistModel *)getNumberPlistModel
{
    [[NSUserDefaults standardUserDefaults]setObject:getNumberPlistModel.numberPlist forKey:@"numberPlist"];
    //同步
    [[NSUserDefaults standardUserDefaults] synchronize];
}



#pragma mark 访问
- (GetNumberPlistModel *)getNumberPlistModel
{
    GetNumberPlistModel * getNumberPlistModel = [[GetNumberPlistModel alloc]init];
    getNumberPlistModel.numberPlist = [[NSUserDefaults standardUserDefaults] stringForKey:@"numberPlist"];
    return getNumberPlistModel;
}


@end
