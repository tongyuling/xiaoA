//
//  PlayController.m
//  xiaoA
//
//  Created by tyl on 17/6/27.
//  Copyright © 2017年 chenlingang. All rights reserved.
//

#import "PlayController.h"
#import "playView.h"
#import "playTool.h"
#import "showPlayImageView.h"
#import "CustomIOSAlertView.h"
#import "Common.h"

@interface PlayController ()

@property (nonatomic, copy) NSString * number;
@property (nonatomic, strong) NSMutableArray *imageData;
@property (nonatomic, strong) CustomIOSAlertView *alert;

@end

@implementation PlayController

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

- (void)viewDidDisappear:(BOOL)animated{
    
    [[playTool sharePlayTool] stopMotion];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //左导航按钮
    UIBarButtonItem * leftBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回image"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];
    leftBtn.tintColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    self.navigationItem.title = @"play";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageData = [NSMutableArray array];
    
    [self buildUI];
}


-(void)buildUI
{
    if (self.playImageData.count == 0) {
        
        //创建alert
        self.alert=[[CustomIOSAlertView alloc]init];
        //加入自定义总的内容
        [self.alert setContainerView:[self createView:@"请先发布动态！"]];
        //展示alertview
        [self.alert show];
        
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [self.alert close];
            
            [self backBtn];
        });
        
        return;
    }
    
    for (int i = 0; i < self.playImageData.count; i++) {

        [self.imageData addObject: [self Base64StrToUIImage:self.playImageData[i]]];
    }
    
    playView *play = [[playView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) imageNameArr:[self.imageData copy] imageSize:CGSizeMake(60,60)];
    play.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:play];
    
    play.clickImageBlock = ^(int imageIndex) {

        UIImage * image = self.imageData[imageIndex];
        CGFloat fixelW;
        CGFloat fixelH;
        
        if (CGImageGetWidth(image.CGImage) >= KviewWidth) {
            fixelW = KviewWidth;
        }else{fixelW = CGImageGetWidth(image.CGImage);}
        
        if (CGImageGetHeight(image.CGImage) >= KviewHeight) {
            fixelH = KviewHeight;
        }else{fixelH = CGImageGetHeight(image.CGImage);}
        
        showPlayImageView * show = [[showPlayImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) imageFrame:CGRectMake(0, 0, fixelW, fixelH)];
        show.iconView.image = image;
        [[[[UIApplication sharedApplication] windows] firstObject] addSubview:show];
    };
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
