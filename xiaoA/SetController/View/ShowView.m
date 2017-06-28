//
//  ShowView.m
//  xiaoA
//
//  Created by qianshi on 16/5/27.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "ShowView.h"
#import "Common.h"

@implementation ShowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}


-(void)buildUI
{
    self.textViewP = [[UITextView alloc]initWithFrame:CGRectMake(10, -64, KviewWidth-20, 100)];
    self.textViewP.text = @"这一刻的想法...";
    self.textViewP.font = [UIFont systemFontOfSize:13];
    self.textViewP.textColor = KcolorRGB(187, 186, 194, 1);
    self.textViewP.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.textViewP];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(self.textViewP.frame.origin.x, 0, self.textViewP.frame.size.width, self.textViewP.frame.size.height)];
    self.textView.font = self.textViewP.font;
    self.textView.textColor = [UIColor blackColor];
    self.textView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.textView];

    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(self.textViewP.frame.origin.x, CGRectGetMaxY(self.textView.frame), self.textViewP.frame.size.width, 0.5)];
    view.backgroundColor = KcolorRGB(220, 220, 220, 1);
    [self addSubview:view];
}



@end
