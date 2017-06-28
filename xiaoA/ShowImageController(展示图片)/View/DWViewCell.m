//
//  DWViewCell.m
//  CardSlide
//
//  Created by DavidWang on 15/11/25.
//  Copyright © 2015年 DavidWang. All rights reserved.
//

#import "DWViewCell.h"
#import "Common.h"

@implementation DWViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 30)];
        //图片适应尺寸
        self.showImg.contentMode = UIViewContentModeScaleToFill; //填充
        self.showImg.clipsToBounds = NO; // 裁剪边缘
        self.showImg.layer.masksToBounds = YES;
        self.showImg.layer.cornerRadius = 5;
        [self addSubview:self.showImg];
        
        UIView * view = [[UIView alloc]init];
        view.frame = CGRectMake(10, 10, 32, 20);
        view.backgroundColor = [UIColor blackColor];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 5;
        view.alpha = 0.8;
        [self.showImg addSubview:view];
        
        UIImageView * image = [[UIImageView alloc]init];
        image.frame = CGRectMake(3, 4, 17, 12);
        image.image = [UIImage imageNamed:@"tupian"];
        [view addSubview:image];
        
        self.labelNumber = [[UILabel alloc]init];
        self.labelNumber.frame = CGRectMake(CGRectGetMaxX(image.frame)+1, 0, 10, view.frame.size.height);
        self.labelNumber.textColor = [UIColor whiteColor];
        self.labelNumber.font = [UIFont systemFontOfSize:11];
        self.labelNumber.textAlignment = NSTextAlignmentCenter;
        [view addSubview:self.labelNumber];
        
    }
    return self;
}


@end
