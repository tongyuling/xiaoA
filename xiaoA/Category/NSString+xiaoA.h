//
//  NSString+xiaoA.h
//  xiaoA
//
//  Created by qianshi on 16/5/23.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (xiaoA)


#pragma mark 字符串后面追加内容
- (NSString *)fileAppend:(NSString *)append;

/**
 ** 去掉字符串的空格
 **/
- (NSString *)trimString;

/**
 ** 是否是空字符串
 **/
- (BOOL)isEmptyString;


+ (NSString *)getMd5_32Bit:(NSString *)str;


@end
