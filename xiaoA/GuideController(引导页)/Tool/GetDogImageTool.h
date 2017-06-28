//
//  GetDogImageTool.h
//  xiaoA
//
//  Created by qianshi on 16/5/26.
//  Copyright © 2016年 chenlingang. All rights reserved.
//
// 保存狗狗头像图片

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "GetDogImageModel.h"

@class GetDogImageModel;
@interface GetDogImageTool : NSObject

single_interface(GetDogImageTool)

/**
 * 保存用户
 **/
- (void)saveGetDogImageModel:(GetDogImageModel *)getDogImageModel;

/**
 * 访问用户
 **/
@property (nonatomic, strong, readonly) GetDogImageModel *getDogImageModel;

@end
