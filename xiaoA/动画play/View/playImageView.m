//
//  playImageView.m
//  xiaoA
//
//  Created by tyl on 17/6/27.
//  Copyright © 2017年 chenlingang. All rights reserved.
//

#import "playImageView.h"

@interface playImageView ()

/**
 在UIDynamicItemGroup类中，有一个collisionBoundsType的属性，可以修改属性值，进而修改控件的碰撞边缘。但这个属性是只读的，所以需要创建一个继承自UIView的类，改写这个属性
 */
@property (nonatomic, assign) UIDynamicItemCollisionBoundsType collisionBoundsType;

@end

@implementation playImageView

@synthesize collisionBoundsType;

- (instancetype)initWithFrame:(CGRect)frame imageName:(UIImage *)imageName
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.image = imageName;
        self.layer.cornerRadius = frame.size.width /2;
        self.layer.masksToBounds = YES;
        self.collisionBoundsType = UIDynamicItemCollisionBoundsTypeEllipse;
    }
    return self;
}



@end
