//
//  ShowSelectController.m
//  xiaoA
//
//  Created by qianshi on 16/6/2.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "ShowSelectController.h"
#import "Common.h"
#import "GetNumberPlistTool.h"
#import "GetNumberPlistModel.h"
#import "NSString+xiaoA.h"
#import "ShowSelectView.h"
#import "showPlayImageView.h"

@interface ShowSelectController ()

@property (nonatomic, strong) ShowSelectView *showSelectView;
@property (nonatomic, strong) UIImage *image1;
@property (nonatomic, strong) UIImage *image2;
@property (nonatomic, strong) UIImage *image3;

@end

@implementation ShowSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    int number = [[GetNumberPlistTool sharedGetNumberPlistTool].getNumberPlistModel.numberPlist intValue];
    int i = number - [self.number intValue];
    NSData * data = [[NSData alloc] initWithContentsOfFile:[self getFilePathWithModelKey:[NSString stringWithFormat:@"test%d",i]]]; 
    //解档辅助类
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    self.navigationItem.title = [unarchiver decodeObjectForKey:@"dataTime"];
    //关闭解档
    [unarchiver finishDecoding];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];

    UIColor * color = KcolorBackRGB;
    [self.navigationController.navigationBar setBackgroundColor:color];
    
    //去掉导航栏下面的黑线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    //创建一个高20的假状态栏背景
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, KviewWidth, 20)];
    statusBarView.backgroundColor=color;
    [self.navigationController.navigationBar addSubview:statusBarView];
    
    //左导航按钮
    UIBarButtonItem * leftBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回image"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];
    leftBtn.tintColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    [self buildUI];
}


-(void)buildUI
{
    int number = [[GetNumberPlistTool sharedGetNumberPlistTool].getNumberPlistModel.numberPlist intValue];
    int i = number - [self.number intValue];
    NSData * data = [[NSData alloc] initWithContentsOfFile:[self getFilePathWithModelKey:[NSString stringWithFormat:@"test%d",i]]]; // +1
    //解档辅助类
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    self.showSelectView = [[ShowSelectView alloc]init];
    self.showSelectView.frame = CGRectMake(0, 0, KviewWidth, KviewHeight);
    //手势
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1)];
    [self.showSelectView.imageView1 addGestureRecognizer:tap1];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2)];
    [self.showSelectView.imageView2 addGestureRecognizer:tap2];
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap3)];
    [self.showSelectView.imageView3 addGestureRecognizer:tap3];
    
    self.showSelectView.labelMessage.text = [unarchiver decodeObjectForKey:@"dataMessage"];
    [self.view addSubview:self.showSelectView];
    
    if ([[unarchiver decodeObjectForKey:@"dataImage2"]isEmptyString]) {
        self.image1 = [self Base64StrToUIImage:[unarchiver decodeObjectForKey:@"dataImage1"]];
        self.showSelectView.imageView1.image = self.image1;
        
        if (CGImageGetHeight(self.image1.CGImage) >= KviewHeight) {
            self.showSelectView.imageView1.frame = CGRectMake(15, 84, KviewWidth/2 -20, KviewWidth/2 + 20);
        }else{
            self.showSelectView.imageView1.frame = CGRectMake(15, 114, KviewWidth/2 -20, KviewWidth/2 -40);
        }
        
        self.showSelectView.labelMessage.frame = CGRectMake(self.showSelectView.imageView1.frame.origin.x, CGRectGetMaxY(self.showSelectView.imageView1.frame), KviewWidth - 30, 80);
    }
    else if ([[unarchiver decodeObjectForKey:@"dataImage3"]isEmptyString]){
        
        self.image1 = [self Base64StrToUIImage:[unarchiver decodeObjectForKey:@"dataImage1"]];
        self.showSelectView.imageView1.image = self.image1;
        self.image2 = [self Base64StrToUIImage:[unarchiver decodeObjectForKey:@"dataImage2"]];
        self.showSelectView.imageView2.image = self.image2;

        if (CGImageGetHeight(self.image1.CGImage) >= KviewHeight) {
            self.showSelectView.imageView1.frame = CGRectMake(15, 84, KviewWidth/2 -20, KviewWidth/2 + 20);
        }else{
            self.showSelectView.imageView1.frame = CGRectMake(15, 114, KviewWidth/2 -20, KviewWidth/2 -40);
        }
        
        if (CGImageGetHeight(self.image2.CGImage) >= KviewHeight) {
            self.showSelectView.imageView2.frame = CGRectMake(CGRectGetMaxX(self.showSelectView.imageView1.frame)+5, 84, KviewWidth/2 -20, KviewWidth/2 + 20);
        }else{
            self.showSelectView.imageView2.frame = CGRectMake(CGRectGetMaxX(self.showSelectView.imageView1.frame)+5, 114, KviewWidth/2 -20, KviewWidth/2 -40);
        }
        
        self.showSelectView.labelMessage.frame = CGRectMake(self.showSelectView.imageView1.frame.origin.x, CGRectGetMaxY(self.showSelectView.imageView1.frame), KviewWidth - 30, 80);
    }
    else{
        self.image1 = [self Base64StrToUIImage:[unarchiver decodeObjectForKey:@"dataImage1"]];
        self.showSelectView.imageView1.image = self.image1;
        self.image2 = [self Base64StrToUIImage:[unarchiver decodeObjectForKey:@"dataImage2"]];
        self.showSelectView.imageView2.image = self.image2;
        self.image3 = [self Base64StrToUIImage:[unarchiver decodeObjectForKey:@"dataImage3"]];
        self.showSelectView.imageView3.image = self.image3;
        
        if (CGImageGetHeight(self.image1.CGImage) >= KviewHeight) {
            self.showSelectView.imageView1.frame = CGRectMake(15, 84, KviewWidth/2 -20, KviewWidth/2 + 20);
        }else{
            self.showSelectView.imageView1.frame = CGRectMake(15, 114, KviewWidth/2 -20, KviewWidth/2 -40);
        }
        
        if (CGImageGetHeight(self.image2.CGImage) >= KviewHeight) {
            self.showSelectView.imageView2.frame = CGRectMake(CGRectGetMaxX(self.showSelectView.imageView1.frame)+5, 84, KviewWidth/2 -20, KviewWidth/2 + 20);
        }else{
            self.showSelectView.imageView2.frame = CGRectMake(CGRectGetMaxX(self.showSelectView.imageView1.frame)+5, 114, KviewWidth/2 -20, KviewWidth/2 -40);
        }
        
        if (CGImageGetHeight(self.image3.CGImage) >= KviewHeight) {
            self.showSelectView.imageView3.frame = CGRectMake(15, CGRectGetMaxY(self.showSelectView.imageView1.frame)+10, KviewWidth/2 -20, KviewWidth/2 + 20);
        }else{
            self.showSelectView.imageView3.frame = CGRectMake(15, CGRectGetMaxY(self.showSelectView.imageView1.frame)+10, KviewWidth/2 -20, KviewWidth/2 -40);
        }
        
        self.showSelectView.labelMessage.frame = CGRectMake(self.showSelectView.imageView1.frame.origin.x, CGRectGetMaxY(self.showSelectView.imageView3.frame), KviewWidth - 30, 80);
    }
    //关闭解档
    [unarchiver finishDecoding];
}

-(void)tap1
{
    CGFloat fixelW;
    CGFloat fixelH;
    
    if (CGImageGetWidth(self.image1.CGImage) >= KviewWidth) {
        fixelW = KviewWidth;
    }else{fixelW = CGImageGetWidth(self.image1.CGImage);}
    
    if (CGImageGetHeight(self.image1.CGImage) >= KviewHeight) {
        fixelH = KviewHeight;
    }else{fixelH = CGImageGetHeight(self.image1.CGImage);}
    
    showPlayImageView * show = [[showPlayImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) imageFrame:CGRectMake(0, 0, fixelW, fixelH)];
    show.iconView.image = self.image1;
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:show];
}
-(void)tap2
{
    CGFloat fixelW;
    CGFloat fixelH;
    
    if (CGImageGetWidth(self.image2.CGImage) >= KviewWidth) {
        fixelW = KviewWidth;
    }else{fixelW = CGImageGetWidth(self.image2.CGImage);}
    
    if (CGImageGetHeight(self.image2.CGImage) >= KviewHeight) {
        fixelH = KviewHeight;
    }else{fixelH = CGImageGetHeight(self.image2.CGImage);}
    
    showPlayImageView * show = [[showPlayImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) imageFrame:CGRectMake(0, 0, fixelW, fixelH)];
    show.iconView.image = self.image2;
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:show];
}
-(void)tap3
{
    CGFloat fixelW;
    CGFloat fixelH;
    
    if (CGImageGetWidth(self.image3.CGImage) >= KviewWidth) {
        fixelW = KviewWidth;
    }else{fixelW = CGImageGetWidth(self.image3.CGImage);}
    
    if (CGImageGetHeight(self.image3.CGImage) >= KviewHeight) {
        fixelH = KviewHeight;
    }else{fixelH = CGImageGetHeight(self.image3.CGImage);}
    
    showPlayImageView * show = [[showPlayImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) imageFrame:CGRectMake(0, 0, fixelW, fixelH)];
    show.iconView.image = self.image3;
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:show];
}

//得到Document目录
-(NSString *) getFilePathWithModelKey:(NSString *)modelkey
{
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[array objectAtIndex:0] stringByAppendingPathComponent:modelkey];
}

#pragma mark 字符串转图片
-(UIImage *)Base64StrToUIImage:(NSString *)encodedImageStr
{
    NSData * decodedImageData = [[NSData alloc]initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}

-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
