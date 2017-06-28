//
//  SetView.m
//  xiaoA
//
//  Created by qianshi on 16/5/23.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "SetView.h"
#import "Common.h"

@implementation SetView


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
    
    self.imageView = [[UIImageView alloc]init];
    self.imageView.center = CGPointMake(KviewWidth/2 - KviewWidth/16, KviewHeight/5.68);
    self.imageView.bounds = CGRectMake(0, 0, KviewWidth/3.2, KviewHeight/5.68);
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2;
    [self addSubview:self.imageView];

    self.labelName = [[UILabel alloc]init];
    self.labelName.frame = CGRectMake(self.imageView.frame.origin.x, CGRectGetMaxY(self.imageView.frame)+10, self.imageView.frame.size.width, 20);
    self.labelName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.labelName];
    
    self.dogImage = [[UIImageView alloc]init];
    self.dogImage.frame = CGRectMake(20, CGRectGetMaxY(self.labelName.frame)+10, KviewWidth - KviewWidth/3.8, KviewHeight/2);
    self.dogImage.userInteractionEnabled = YES;
    [self addSubview:self.dogImage];
    
    self.labelMessage = [[UILabel alloc]init];
    self.labelMessage.center = CGPointMake(self.dogImage.frame.size.width/2, 150);
    self.labelMessage.bounds = CGRectMake(0, 0, self.dogImage.frame.size.width - 40, 150);
    self.labelMessage.numberOfLines = 0;
    self.labelMessage.textColor = [UIColor whiteColor];
    self.labelMessage.font = [UIFont systemFontOfSize:15];
    [self.dogImage addSubview:self.labelMessage];
    self.labelMessage.alpha = 0.8;
    
    self.labelTime = [[UILabel alloc]init];
    self.labelTime.frame = CGRectMake(self.labelMessage.frame.origin.x, CGRectGetMaxY(self.labelMessage.frame), self.labelMessage.frame.size.width, 20);
    self.labelTime.font = [UIFont systemFontOfSize:13];
    self.labelTime.textColor = [UIColor whiteColor];
    self.labelTime.textAlignment = NSTextAlignmentRight;
    [self.dogImage addSubview:self.labelTime];
    self.labelTime.alpha = 0.8;
    
    self.alertbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.alertbtn.frame = CGRectMake(self.dogImage.frame.origin.x + 13, CGRectGetMaxY(self.dogImage.frame)+20, 50, 50);
    [self.alertbtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self addSubview:self.alertbtn];
    [self.alertbtn setTitle:@"爱犬信息" forState:UIControlStateNormal];
    [self.alertbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.alertbtn.titleLabel.font = [UIFont systemFontOfSize:11];
    
    self.showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.showBtn.frame = CGRectMake(CGRectGetMaxX(self.alertbtn.frame)+30, self.alertbtn.frame.origin.y, self.alertbtn.frame.size.width, self.alertbtn.frame.size.height);
    [self addSubview:self.showBtn];
    [self.showBtn setTitle:@"爱犬动态" forState:UIControlStateNormal];
    [self.showBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.showBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(CGRectGetMaxX(self.showBtn.frame)+30, self.alertbtn.frame.origin.y, self.alertbtn.frame.size.width, self.alertbtn.frame.size.height);
    [self addSubview:self.backBtn];
    [self.backBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.backBtn.titleLabel.font = [UIFont systemFontOfSize:11];
}



@end
