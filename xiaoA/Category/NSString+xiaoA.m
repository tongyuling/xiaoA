//
//  NSString+xiaoA.m
//  xiaoA
//
//  Created by qianshi on 16/5/23.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "NSString+xiaoA.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (xiaoA)

#pragma mark 在字符串后面追加内容
- (NSString *)fileAppend:(NSString *)append
{
    NSString *imageStr = nil;
    //1.1.获取后缀名
    NSString *ext = [self pathExtension];
    if (![@"" isEqualToString:ext])
    {   //后缀名不为空
        //1.2.删除后缀名
        imageStr = [self stringByDeletingPathExtension];
        //1.3.追加内容
        imageStr = [imageStr stringByAppendingString:append];
        //1.4.追加后缀名
        imageStr = [imageStr stringByAppendingPathExtension:ext];
    }
    else
    {//后缀名为空
        imageStr = [self stringByAppendingString:append];
    }
    return imageStr;
}

#pragma mark 去掉字符串的空格
- (NSString *)trimString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark 是否是空字符串
- (BOOL)isEmptyString {
    return (self.length == 0);
}


+ (NSString *)getMd5_32Bit:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)str.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}



@end
