//
//  playView.h
//  xiaoA
//
//  Created by tyl on 17/6/27.
//  Copyright © 2017年 chenlingang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickImageBlock)(int imageIndex);

@interface playView : UIView

@property (nonatomic, strong) ClickImageBlock clickImageBlock;

/**
 MotionView初始化方法
 
 @param frame MotionView的frame
 @param imageArr 图片集合
 @param imageSize 图片大小
 @return MotionView
 */

- (instancetype)initWithFrame:(CGRect)frame imageNameArr:(NSArray *)imageArr imageSize:(CGSize)imageSize;

@end
