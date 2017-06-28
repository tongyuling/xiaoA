//
//  GetNumberPlistTool.h
//  xiaoA
//
//  Created by qianshi on 16/5/27.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "GetNumberPlistModel.h"

@class GetNumberPlistModel;
@interface GetNumberPlistTool : NSObject

single_interface(GetNumberPlistTool)

/**
 * 保存用户
 **/
- (void)saveGetNumberPlistModel:(GetNumberPlistModel *)getNumberPlistModel;

/**
 * 访问用户
 **/
@property (nonatomic, strong, readonly) GetNumberPlistModel *getNumberPlistModel;


@end
