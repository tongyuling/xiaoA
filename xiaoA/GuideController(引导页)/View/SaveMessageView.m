//
//  SaveMessageView.m
//  xiaoA
//
//  Created by qianshi on 16/5/25.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "SaveMessageView.h"
#import "Common.h"

@implementation SaveMessageView

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
    UIColor * color = KcolorBackRGB;
    
    UILabel * label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 40, KviewWidth, 25);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"爱犬信息";
    label.font = [UIFont systemFontOfSize:17];
    [self addSubview:label];
    
    self.imageView = [[UIImageView alloc]init];
    self.imageView.userInteractionEnabled = YES;
    self.imageView.center = CGPointMake(KviewWidth/2, 130);
    self.imageView.bounds = CGRectMake(0, 0, KviewWidth/3.2, KviewHeight/5.68);
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2;
    [self addSubview:self.imageView];
    self.imageView.backgroundColor = color;

    UILabel * label1 = [[UILabel alloc]init];
    label1.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+30, KviewWidth/2.5, label.frame.size.height);
    label1.text = @"爱犬名字：";
    label1.font = [UIFont systemFontOfSize:15];
    label1.textAlignment = NSTextAlignmentRight;
    [self addSubview:label1];
    
    self.textName = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), label1.frame.origin.y, KviewWidth/2, label1.frame.size.height)];
    self.textName.textAlignment = NSTextAlignmentLeft;
    self.textName.placeholder = @"请输入爱犬名字",
    self.textName.tag = 10;
    self.textName.font = label1.font;
    self.textName.tintColor = color;
    self.textName.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:self.textName];
    
    UILabel * label2 = [[UILabel alloc]init];
    label2.frame = CGRectMake(0, CGRectGetMaxY(label1.frame)+20, label1.frame.size.width, label1.frame.size.height);
    label2.text = @"爱犬年龄：";
    label2.font = label1.font;
    label2.textAlignment = NSTextAlignmentRight;
    [self addSubview:label2];
    
    self.textAge = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame), label2.frame.origin.y, self.textName.frame.size.width, self.textName.frame.size.height)];
    self.textAge.textAlignment = NSTextAlignmentLeft;
    self.textAge.placeholder = @"请输入爱犬年龄",
    self.textAge.keyboardType = UIKeyboardTypeNumberPad;
    self.textAge.tag = 11;
    self.textAge.font = self.textName.font;
    self.textAge.tintColor = color;
    self.textAge.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:self.textAge];
    
    UILabel * label3 = [[UILabel alloc]init];
    label3.frame = CGRectMake(0, CGRectGetMaxY(label2.frame)+20, label1.frame.size.width, label1.frame.size.height);
    label3.text = @"爱犬种类：";
    label3.font = label1.font;
    label3.textAlignment = NSTextAlignmentRight;
    [self addSubview:label3];
    
    self.textVariety = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame), label3.frame.origin.y, self.textName.frame.size.width, self.textName.frame.size.height)];
    self.textVariety.textAlignment = NSTextAlignmentLeft;
    self.textVariety.placeholder = @"请选择爱犬种类",
    self.textVariety.tag = 12;
    self.textVariety.font = self.textName.font;
    self.textVariety.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:self.textVariety];
    
    UILabel * label4 = [[UILabel alloc]init];
    label4.frame = CGRectMake(0, CGRectGetMaxY(label3.frame)+20, label1.frame.size.width, label1.frame.size.height);
    label4.text = @"爱犬性别：";
    label4.font = label1.font;
    label4.textAlignment = NSTextAlignmentRight;
    [self addSubview:label4];
    
    self.textSex = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label4.frame), label4.frame.origin.y, self.textName.frame.size.width, self.textName.frame.size.height)];
    self.textSex.textAlignment = NSTextAlignmentLeft;
    self.textSex.placeholder = @"请选择爱犬性别",
    self.textSex.tag = 13;
    self.textSex.font = self.textName.font;
    self.textSex.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:self.textSex];
    
    UILabel * label5 = [[UILabel alloc]init];
    label5.frame = CGRectMake(0, CGRectGetMaxY(label4.frame)+20, label1.frame.size.width, label1.frame.size.height);
    label5.text = @"爱犬特点：";
    label5.font = label1.font;
    label5.textAlignment = NSTextAlignmentRight;
    [self addSubview:label5];
    
    self.textViewP = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label5.frame), label5.frame.origin.y - 5, self.textName.frame.size.width, self.textName.frame.size.height * 4)];
    self.textViewP.text = @"如：活泼等";
    self.textViewP.font = self.textName.font;
    self.textViewP.textColor = KcolorRGB(187, 186, 194, 1);
    [self addSubview:self.textViewP];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label5.frame), label5.frame.origin.y - 5, self.textName.frame.size.width, self.textName.frame.size.height * 4)];
    self.textView.font = self.textName.font;
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.tintColor = color;
    UIColor * c = KcolorRGB(187, 186, 194, 1);
    self.textView.layer.borderColor = c.CGColor;
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.cornerRadius = 6;
    self.textView.layer.masksToBounds = YES;
    [self addSubview:self.textView];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(10, KviewHeight - 60, KviewWidth - 20, 45);
    self.btn.backgroundColor = color;
    [self.btn setTitle:@"提 交" forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.cornerRadius = 5;
    [self addSubview:self.btn];
}


@end
