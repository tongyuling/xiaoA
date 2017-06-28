//
//  UIImage+xiaoA.h
//  xiaoA
//
//  Created by qianshi on 16/5/23.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (xiaoA)

#pragma mark 加载全屏图片
+(UIImage *)fullScreenImage:(NSString *)image;

#pragma mark color转image
+ (UIImage *)createImageWithColor:(UIColor *)color;

//压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

@end
