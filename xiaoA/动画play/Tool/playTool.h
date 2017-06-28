//
//  playTool.h
//  xiaoA
//
//  Created by tyl on 17/6/27.
//  Copyright © 2017年 chenlingang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface playTool : NSObject

@property (nonatomic, strong) UIView *referenceView;

+ (instancetype)sharePlayTool;


/**
 给view添加行为
 
 @param aimView 目标view
 @param referenceView 参考view
 */
- (void)addAimView:(UIView *)aimView referenceView:(UIView *)referenceView;

- (void)stopMotion;

@end
