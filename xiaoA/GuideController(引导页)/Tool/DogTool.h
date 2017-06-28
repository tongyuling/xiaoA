//
//  DogTool.h
//  xiaoA
//
//  Created by qianshi on 16/5/25.
//  Copyright © 2016年 chenlingang. All rights reserved.
//
// 保存狗狗信息

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "DogModel.h"

@class DogModel;
@interface DogTool : NSObject

single_interface(DogTool)

/**
 * 保存用户
 **/
- (void)saveDogModel:(DogModel *)dogModel;

/**
 * 访问用户
 **/
@property (nonatomic, strong, readonly) DogModel *dogModel;


@end
