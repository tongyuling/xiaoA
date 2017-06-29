//
//  ShowSelectView.m
//  xiaoA
//
//  Created by qianshi on 16/6/2.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "ShowSelectView.h"
#import "Common.h"

@implementation ShowSelectView

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
    self.backgroundColor = [UIColor whiteColor];
    
    self.imageView1 = [[UIImageView alloc]init];
    self.imageView1.frame = CGRectMake(15, 84, KviewWidth/2 -20, KviewWidth/2 + 20);
    self.imageView1.userInteractionEnabled = YES;
    [self addSubview:self.imageView1];
    
    self.imageView2 = [[UIImageView alloc]init];
    self.imageView2.frame = CGRectMake(CGRectGetMaxX(self.imageView1.frame)+5, self.imageView1.frame.origin.y, self.imageView1.frame.size.width, self.imageView1.frame.size.height);
    self.imageView2.userInteractionEnabled = YES;
    [self addSubview:self.imageView2];
    
    self.imageView3 = [[UIImageView alloc]init];
    self.imageView3.frame = CGRectMake(self.imageView1.frame.origin.x, CGRectGetMaxY(self.imageView1.frame)+10, self.imageView1.frame.size.width, self.imageView1.frame.size.height);
    self.imageView3.userInteractionEnabled = YES;
    [self addSubview:self.imageView3];
    
    self.labelMessage = [[UILabel alloc]init];
    self.labelMessage.numberOfLines = 0;
    self.labelMessage.frame = CGRectMake(self.imageView1.frame.origin.x, CGRectGetMaxY(self.imageView3.frame), KviewWidth - 30, 80);
    self.labelMessage.font = [UIFont systemFontOfSize:15];
    self.labelMessage.textColor = [UIColor blackColor];
    self.labelMessage.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.labelMessage];
}


@end
