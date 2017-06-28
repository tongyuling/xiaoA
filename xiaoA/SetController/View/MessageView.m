//
//  MessageView.m
//  xiaoA
//
//  Created by qianshi on 16/5/24.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "MessageView.h"
#import "Common.h"
#import "GetDogImageTool.h"
#import "GetDogImageModel.h"

@implementation MessageView


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
    
    self.imageView = [[UIImageView alloc]init];
    self.imageView.userInteractionEnabled = YES;
    self.imageView.center = CGPointMake(KviewWidth/5, KviewHeight/3);
    self.imageView.bounds = CGRectMake(0, 0, KviewWidth/3.2, KviewHeight/5.68);
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2;
    NSString * str = [GetDogImageTool sharedGetDogImageTool].getDogImageModel.dogImage;
    if (str == nil) {
        self.imageView.backgroundColor = color;
    }
    else{
        self.imageView.image = [self Base64StrToUIImage:str];
    }
    [self addSubview:self.imageView];
    
    UILabel * label = [[UILabel alloc]init];
    label.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)+30, 85, KviewWidth/2, 30);
    label.text = @"爱犬名字：";
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:15];
    [self addSubview:label];
    
    self.textName = [[UITextField alloc]init];
    self.textName.frame = CGRectMake(label.frame.origin.x, CGRectGetMaxY(label.frame), label.frame.size.width, label.frame.size.height);
    self.textName.font = label.font;
    self.textName.textAlignment = NSTextAlignmentLeft;
    self.textName.tintColor = color;
    self.textName.borderStyle = UITextBorderStyleRoundedRect;
    self.textName.tag = 10;
    [self addSubview:self.textName];
    
    UILabel * label1 = [[UILabel alloc]init];
    label1.frame = CGRectMake(label.frame.origin.x, CGRectGetMaxY(self.textName.frame), label.frame.size.width, label.frame.size.height);
    label1.text = @"爱犬年龄：";
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = label.font;
    [self addSubview:label1];
    
    self.textAge = [[UITextField alloc]init];
    self.textAge.frame = CGRectMake(label1.frame.origin.x, CGRectGetMaxY(label1.frame), label1.frame.size.width, label1.frame.size.height);
    self.textAge.font = label.font;
    self.textAge.textAlignment = NSTextAlignmentLeft;
    self.textAge.tintColor = color;
    self.textAge.keyboardType = UIKeyboardTypeNumberPad;
    self.textAge.borderStyle = UITextBorderStyleRoundedRect;
    self.textAge.tag = 11;
    [self addSubview:self.textAge];
    
    UILabel * label2 = [[UILabel alloc]init];
    label2.frame = CGRectMake(label.frame.origin.x, CGRectGetMaxY(self.textAge.frame), label.frame.size.width, label.frame.size.height);
    label2.text = @"爱犬种类：";
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = label.font;
    [self addSubview:label2];
    
    self.textVariety = [[UITextField alloc]init];
    self.textVariety.frame = CGRectMake(label2.frame.origin.x, CGRectGetMaxY(label2.frame), label2.frame.size.width, label2.frame.size.height);
    self.textVariety.font = label.font;
    self.textVariety.textAlignment = NSTextAlignmentLeft;
    self.textVariety.borderStyle = UITextBorderStyleRoundedRect;
    self.textVariety.tag = 12;
    [self addSubview:self.textVariety];
    
    UILabel * label3 = [[UILabel alloc]init];
    label3.frame = CGRectMake(label.frame.origin.x, CGRectGetMaxY(self.textVariety.frame), label.frame.size.width, label.frame.size.height);
    label3.text = @"爱犬性别：";
    label3.textAlignment = NSTextAlignmentLeft;
    label3.font = label.font;
    [self addSubview:label3];
    
    self.textSex = [[UITextField alloc]init];
    self.textSex.frame = CGRectMake(label3.frame.origin.x, CGRectGetMaxY(label3.frame), label3.frame.size.width, label3.frame.size.height);
    self.textSex.font = label.font;
    self.textSex.textAlignment = NSTextAlignmentLeft;
    self.textSex.borderStyle = UITextBorderStyleRoundedRect;
    self.textSex.tag = 13;
    [self addSubview:self.textSex];
    
    UILabel * label4 = [[UILabel alloc]init];
    label4.frame = CGRectMake(self.imageView.frame.origin.x, CGRectGetMaxY(self.textSex.frame) + 10, self.imageView.frame.size.width, label.frame.size.height);
    label4.text = @"爱犬特点：";
    label4.textAlignment = NSTextAlignmentRight;
    label4.font = label.font;
    [self addSubview:label4];
    
    self.textView = [[UITextView alloc]init];
    self.textView.frame = CGRectMake(CGRectGetMaxX(label4.frame), label4.frame.origin.y - 2, label4.frame.size.width * 1.9, 150);
    self.textView.tintColor = color;
    self.textView.font = [UIFont systemFontOfSize:15];
    UIColor * c = KcolorRGB(187, 186, 194, 1);
    self.textView.layer.borderColor = c.CGColor;
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.cornerRadius = 6;
    self.textView.layer.masksToBounds = YES;
    [self addSubview:self.textView];
}

#pragma mark 字符串转图片
-(UIImage *)Base64StrToUIImage:(NSString *)encodedImageStr
{
    NSData * decodedImageData = [[NSData alloc]initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}

@end

