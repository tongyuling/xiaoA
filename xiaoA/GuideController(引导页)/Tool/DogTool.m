//
//  DogTool.m
//  xiaoA
//
//  Created by qianshi on 16/5/25.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "DogTool.h"
#import "DogModel.h"

@implementation DogTool

single_implementation(DogTool)

#pragma mark 保存
- (void)saveDogModel:(DogModel *)dogModel
{
    [[NSUserDefaults standardUserDefaults]setObject:dogModel.dogName forKey:@"dogName"];
    [[NSUserDefaults standardUserDefaults]setObject:dogModel.dogAge forKey:@"dogAge"];
    [[NSUserDefaults standardUserDefaults]setObject:dogModel.dogVariety forKey:@"dogVariety"];
    [[NSUserDefaults standardUserDefaults]setObject:dogModel.dogSex forKey:@"dogSex"];
    [[NSUserDefaults standardUserDefaults]setObject:dogModel.dogMessage forKey:@"dogMessage"];
    //同步
    [[NSUserDefaults standardUserDefaults] synchronize];
}




#pragma mark 访问
- (DogModel *)dogModel
{
    DogModel * dogModel = [[DogModel alloc]init];
    
    dogModel.dogName = [[NSUserDefaults standardUserDefaults] stringForKey:@"dogName"];
    dogModel.dogAge = [[NSUserDefaults standardUserDefaults] stringForKey:@"dogAge"];
    dogModel.dogVariety = [[NSUserDefaults standardUserDefaults] stringForKey:@"dogVariety"];
    dogModel.dogSex = [[NSUserDefaults standardUserDefaults] stringForKey:@"dogSex"];
    dogModel.dogMessage = [[NSUserDefaults standardUserDefaults] stringForKey:@"dogMessage"];
    
    return dogModel;
}



@end
