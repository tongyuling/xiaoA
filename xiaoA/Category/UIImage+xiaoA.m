//
//  UIImage+xiaoA.m
//  xiaoA
//
//  Created by qianshi on 16/5/23.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "UIImage+xiaoA.h"
#import "NSString+xiaoA.h"

@implementation UIImage (xiaoA)

#pragma mark 加载全屏图片
+(UIImage *)fullScreenImage:(NSString *)image
{
    //判断屏幕大小
    //iphone4、4s
    if ([UIScreen mainScreen].bounds.size.height == 480 )
    {
        image = [image fileAppend:@""];
    }
    //iphone5、5s
    if ([UIScreen mainScreen].bounds.size.height == 568 )
    {
        image = [image fileAppend:@""];
    }
    //iphone6
    if ([UIScreen mainScreen].bounds.size.height == 667 && [UIScreen mainScreen].bounds.size.width == 375)
    {
        image = [image fileAppend:@""];
    }
    //iphone6Plus
    if ([UIScreen mainScreen].bounds.size.height == 960 && [UIScreen mainScreen].bounds.size.width == 540)
    {
        image = [image fileAppend:@""];
    }
    return [self imageNamed:image];
}


#pragma mark color转image
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end
