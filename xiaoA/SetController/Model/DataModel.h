//
//  DataModel.h
//  xiaoA
//
//  Created by qianshi on 16/6/1.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject<NSCoding>

@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *image1;
@property (nonatomic, strong) NSString *image2;
@property (nonatomic, strong) NSString *image3;

@end
