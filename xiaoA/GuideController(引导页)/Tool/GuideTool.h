//
//  GuideTool.h
//  xiaoA
//
//  Created by qianshi on 16/5/23.
//  Copyright © 2016年 chenlingang. All rights reserved.
//
// 保存地址

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "GuideModel.h"

@class GuideModel;
@interface GuideTool : NSObject

single_interface(GuideTool)

/**
 * 保存用户
 **/
- (void)saveGuideModel:(GuideModel *)guideModel;

/**
 * 访问用户
 **/
@property (nonatomic, strong, readonly) GuideModel *guideModel;



@end
