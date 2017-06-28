//
//  GetDogImageTool.m
//  xiaoA
//
//  Created by qianshi on 16/5/26.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "GetDogImageTool.h"
#import "GetDogImageModel.h"

@implementation GetDogImageTool

single_implementation(GetDogImageTool)

#pragma mark 保存
- (void)saveGetDogImageModel:(GetDogImageModel *)getDogImageModel
{
    [[NSUserDefaults standardUserDefaults]setObject:getDogImageModel.dogImage forKey:@"dogImage"];
    //同步
    [[NSUserDefaults standardUserDefaults] synchronize];
}




#pragma mark 访问
- (GetDogImageModel *)getDogImageModel
{
    GetDogImageModel * getDogImageModel = [[GetDogImageModel alloc]init];
    getDogImageModel.dogImage = [[NSUserDefaults standardUserDefaults] stringForKey:@"dogImage"];
    return getDogImageModel;
}


@end
