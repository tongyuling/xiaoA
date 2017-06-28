//
//  LoginModel.h
//  xiaoA
//
//  Created by qianshi on 16/5/25.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject
@property (nonatomic, copy) NSString * loginName;
@property (nonatomic, copy) NSString * loginImage;

-(id)initWithLoginName:(NSString *)loginName loginImage:(NSString *)loginImage;
@end
