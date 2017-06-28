//
//  DogModel.h
//  xiaoA
//
//  Created by qianshi on 16/5/25.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DogModel : NSObject

@property (nonatomic, copy) NSString * dogName;
@property (nonatomic, copy) NSString * dogAge;
@property (nonatomic, copy) NSString * dogVariety;
@property (nonatomic, copy) NSString * dogSex;
@property (nonatomic, copy) NSString * dogMessage;

-(id)initWithDogName:(NSString *)dogName dogAge:(NSString *)dogAge dogVariety:(NSString *)dogVariety dogSex:(NSString *)dogSex dogMessage:(NSString *)dogMessage;

@end
