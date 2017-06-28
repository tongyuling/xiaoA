//
//  GuideModel.h
//  xiaoA
//
//  Created by qianshi on 16/5/23.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuideModel : NSObject

@property (nonatomic, copy) NSString * jingDu;
@property (nonatomic, copy) NSString * weiDu;
@property (nonatomic, copy) NSString *address;

-(id)initWithJingDu:(NSString *)jingDu weiDu:(NSString *)weiDu address:(NSString *)address;

@end
