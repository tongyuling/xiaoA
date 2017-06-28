//
//  showPlayImageView.m
//  xiaoA
//
//  Created by tyl on 17/6/27.
//  Copyright © 2017年 chenlingang. All rights reserved.
//

#import "showPlayImageView.h"
#import "Common.h"

@implementation showPlayImageView

- (instancetype)initWithFrame:(CGRect)frame imageFrame:(CGRect)imageFrame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = KcolorRGB(40, 43, 53, 1);
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapA)];
        [self addGestureRecognizer:tap];
        
        self.iconView = [[UIImageView alloc]init];
        self.iconView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        self.iconView.bounds = imageFrame;
        [self addSubview:self.iconView];
    }
    return self;
}

-(void)tapA
{
    [UIView animateWithDuration:0.5 animations:^{
        [self removeFromSuperview];
    }];
}

@end
