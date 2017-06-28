//
//  SetController.m
//  xiaoA
//
//  Created by qianshi on 16/5/23.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "SetController.h"
#import "Common.h"
#import "GuideTool.h"
#import "GuideModel.h"
#import "SetView.h"
#import "ShowController.h"
#import "MessageController.h"
#import "CustomIOSAlertView.h"
#import "UMSocial.h"
#import "LoginModel.h"
#import "LoginTool.h"
#import "GuideController.h"
#import "MMProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "GetNumberPlistTool.h"
#import "GetNumberPlistModel.h"

@interface SetController ()<CustomIOSAlertViewDelegate>

@property (nonatomic, strong) SetView *setView;
@property (nonatomic, strong) CustomIOSAlertView *alert;

@end

@implementation SetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


-(void)buildUI
{
    self.setView = [[SetView alloc]init];
    self.setView.frame = CGRectMake(0, 0, KviewWidth, KviewHeight);
    [self.view addSubview:self.setView];
    
    NSString * image = [LoginTool sharedLoginTool].loginModel.loginImage;
    [self.setView.imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:nil];
    NSString * name = [LoginTool sharedLoginTool].loginModel.loginName;
    self.setView.labelName.text = name;
    [self.setView.showBtn addTarget:self action:@selector(btnShow) forControlEvents:UIControlEventTouchUpInside];
    [self.setView.backBtn addTarget:self action:@selector(btnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.setView.alertbtn addTarget:self action:@selector(btnAlert) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer * tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage)];
    [self.setView.dogImage addGestureRecognizer:tapImage];

    if ([[GetNumberPlistTool sharedGetNumberPlistTool].getNumberPlistModel.numberPlist isEqualToString:@"0"]) {
        self.setView.labelMessage.textColor = [UIColor lightGrayColor];
        self.setView.labelMessage.text = @"您还没有给爱犬发布动态，赶快发布吧！";
    }
    else{
        
        NSData * data = [[NSData alloc] initWithContentsOfFile:[self getFilePathWithModelKey:[NSString stringWithFormat:@"test%@",[GetNumberPlistTool sharedGetNumberPlistTool].getNumberPlistModel.numberPlist]]];
        //解档辅助类
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        //解码并解档出model
        self.setView.dogImage.image = [self Base64StrToUIImage:[unarchiver decodeObjectForKey:@"dataImage1"]];
//        self.setView.labelMessage.text = [unarchiver decodeObjectForKey:@"dataMessage"];
//        self.setView.labelMessage.textColor = [UIColor whiteColor];
//        self.setView.labelTime.text = [unarchiver decodeObjectForKey:@"dataTime"];
        //关闭解档
        [unarchiver finishDecoding];
    }
    
    // 通知中心
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goChangeLabel:) name:@"fabu" object:nil];
}

//得到Document目录
-(NSString *) getFilePathWithModelKey:(NSString *)modelkey
{
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[array objectAtIndex:0] stringByAppendingPathComponent:modelkey];
}

#pragma mark 通知中心方法
-(void)goChangeLabel:(NSNotification *)notification
{
    NSData * data = [[NSData alloc] initWithContentsOfFile:[self getFilePathWithModelKey:[NSString stringWithFormat:@"test%@",[GetNumberPlistTool sharedGetNumberPlistTool].getNumberPlistModel.numberPlist]]];
    //解档辅助类
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //解码并解档出model
    self.setView.dogImage.image = [self Base64StrToUIImage:[unarchiver decodeObjectForKey:@"dataImage1"]];
//    self.setView.labelMessage.text = [unarchiver decodeObjectForKey:@"dataMessage"];
//    self.setView.labelMessage.textColor = [UIColor whiteColor];
//    self.setView.labelTime.text = [unarchiver decodeObjectForKey:@"dataTime"];
    //关闭解档
    [unarchiver finishDecoding];
}


#pragma mark 点击图片方法
-(void)tapImage
{
    
}

-(void)btnAlert
{
    MessageController * message = [[MessageController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:message];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)btnShow
{
    ShowController * show = [[ShowController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:show];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)btnBack
{
    //创建alert
    self.alert=[[CustomIOSAlertView alloc]init];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.alert addGestureRecognizer:tap];
    //加入自定义总的内容
    [self.alert setContainerView:[self createView:@"确定要退出登录吗？"]];
    //button
    [self.alert setButtonTitles:@[@"确定"]];
    [self.alert setDelegate:self];
    //展示alertview
    [self.alert show];
}

-(void)tap
{
    [self.alert close];
}

#pragma mark alertview自定义总的内容
-(UIView *)createView:(NSString *)message
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KviewWidth/1.6, KviewHeight/5.84)];
    //labela
    UILabel * labela=[[UILabel alloc]initWithFrame:CGRectMake(0, KviewHeight/28.4, demoView.frame.size.width, KviewHeight/28.4)];
    labela.text=@"提示";
    if (iPhone4) {
        labela.font=[UIFont systemFontOfSize:16];
    }
    if (iPhone5) {
        labela.font=[UIFont systemFontOfSize:17];
    }
    if (iPhone6) {
        labela.font=[UIFont systemFontOfSize:18];
    }
    if (iPhone6p) {
        labela.font=[UIFont systemFontOfSize:21];
    }
    labela.textAlignment=NSTextAlignmentCenter;
    [demoView addSubview:labela];
    
    //labelb
    UILabel * labelb=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(labela.frame)+KviewHeight/37.9, demoView.frame.size.width, KviewHeight/28.4)];
    labelb.textAlignment=NSTextAlignmentCenter;
    labelb.textColor=[UIColor lightGrayColor];
    labelb.text=message;
    if (iPhone4) {
        labelb.font=[UIFont systemFontOfSize:14];
    }
    if (iPhone5) {
        labelb.font=[UIFont systemFontOfSize:15];
    }
    if (iPhone6) {
        labelb.font=[UIFont systemFontOfSize:16];
    }
    if (iPhone6p) {
        labelb.font=[UIFont systemFontOfSize:19];
    }
    [demoView addSubview:labelb];
    
    return demoView;
}

#pragma mark alertview delegate
- (void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 1.菊花转动
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithTitle:@"提示" status:@"正在退出..."];
    
    if (buttonIndex==0) {
        //关闭alertview
        [alertView close];
        
        //删除授权调用下面的方法
        [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
            NSString * str = [NSString stringWithFormat:@"%u",response.responseCode];
            if ([str isEqualToString:@"200"]) {
                [MMProgressHUD dismissWithSuccess:@"退出成功" title:@"成功"];
                
                NSString * name = @"";
                NSString * image = [LoginTool sharedLoginTool].loginModel.loginImage;
                LoginModel * model = [[LoginModel alloc]initWithLoginName:name loginImage:image];
                [[LoginTool sharedLoginTool] saveLoginModel:model];
                
                GuideController * guide = [[GuideController alloc]init];
                self.view.window.rootViewController = guide;
            }
            else{
                [MMProgressHUD dismissWithSuccess:@"退出失败" title:@"失败"];
            }
        }];
    }
}


#pragma mark 字符串转图片
-(UIImage *)Base64StrToUIImage:(NSString *)encodedImageStr
{
    NSData * decodedImageData = [[NSData alloc]initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}

@end
