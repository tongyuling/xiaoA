//
//  GuideTool.m
//  xiaoA
//
//  Created by qianshi on 16/5/23.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "GuideTool.h"
#import "GuideModel.h"

@implementation GuideTool

single_implementation(GuideTool)

#pragma mark 保存
- (void)saveGuideModel:(GuideModel *)guideModel
{
    [[NSUserDefaults standardUserDefaults]setObject:guideModel.jingDu forKey:@"jingDu"];
    [[NSUserDefaults standardUserDefaults]setObject:guideModel.weiDu forKey:@"weiDu"];
    [[NSUserDefaults standardUserDefaults]setObject:guideModel.address forKey:@"address"];
    //同步
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark 访问
- (GuideModel *)guideModel
{
    GuideModel * guideModel = [[GuideModel alloc]init];
    guideModel.jingDu = [[NSUserDefaults standardUserDefaults] stringForKey:@"jingDu"];
    guideModel.weiDu = [[NSUserDefaults standardUserDefaults] stringForKey:@"weiDu"];
    guideModel.address = [[NSUserDefaults standardUserDefaults] stringForKey:@"address"];
    return guideModel;
}


@end
