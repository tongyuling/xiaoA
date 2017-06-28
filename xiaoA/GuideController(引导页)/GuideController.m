//
//  GuideController.m
//  xiaoA
//
//  Created by qianshi on 16/5/23.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "GuideController.h"
#import "Common.h"
#import "UMSocial.h"
#import "LoginModel.h"
#import "LoginTool.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "SetController.h"
#import "ShowImageController.h"
#import "MMProgressHUD.h"
#import "SaveMessageController.h"

@interface GuideController ()

@end

@implementation GuideController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = KcolorBackRGB;
    
    [self load];
}



-(void)load
{
    //取出gif图转换成data
//    NSString * filePath = [[NSBundle mainBundle]pathForResource:@"railway" ofType:@"gif"];
//    NSData * gif = [NSData dataWithContentsOfFile:filePath];
//    
//    //用webview展示
//    UIWebView * webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+20)];
//    webView.userInteractionEnabled=NO;
//    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL URLWithString:@""]];
//    [self.view addSubview:webView];
    
    //添加控件
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 100)];
    welcomeLabel.text = @"WELCOME";
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.font = [UIFont systemFontOfSize:50];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:welcomeLabel];
    
    UIButton *qqBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 420, 240, 40)];
    qqBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    qqBtn.layer.borderWidth = 2.0;
    qqBtn.titleLabel.font = [UIFont systemFontOfSize:24];
    [qqBtn setTintColor:[UIColor orangeColor]];
    [qqBtn setTitle:@"QQ登录" forState:UIControlStateNormal];
    [qqBtn addTarget:self action:@selector(loginQQ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqBtn];
}


-(void)loginQQ
{
    // 1.菊花转动
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            [MMProgressHUD showWithTitle:@"提示" status:@"登录成功..."];
            double delayInSeconds = 0.8;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MMProgressHUD dismiss];
            });
            
            if (self.number == 10000) {
                SaveMessageController * message = [[SaveMessageController alloc]init];
                [self presentViewController:message animated:YES completion:nil];
            }
            else{
                [self buildUI];
            }
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            //qq昵称，uid，令牌，头像图片URL
            //其中这一段snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL分别代表qq昵称，uid，令牌，头像图片URL
            LoginModel * model = [[LoginModel alloc]initWithLoginName:snsAccount.userName loginImage:snsAccount.iconURL];
            [[LoginTool sharedLoginTool] saveLoginModel:model];
            
        }
        else{
            [MMProgressHUD dismiss];
        }
    });
}


-(void)buildUI
{
    //进入主界面
    ShowImageController * show = [[ShowImageController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:show];
    self.view.window.rootViewController = nav;
    
//    UIViewController * left = [[SetController alloc] init];
//    UIViewController * center = [[ShowImageController alloc] init];
//    
//    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:center];
//    
//    MMDrawerController * drawerController = [[MMDrawerController alloc]
//                                             initWithCenterViewController:nav
//                                             leftDrawerViewController:left
//                                             rightDrawerViewController:nil];
//    [drawerController setMaximumRightDrawerWidth:KviewWidth/1.16];
//    [drawerController setMaximumLeftDrawerWidth:KviewWidth/1.16];
//    
//    //[drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
//    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
//    
//    [drawerController
//     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
//         MMDrawerControllerDrawerVisualStateBlock block;
//         block = [[MMExampleDrawerVisualStateManager sharedManager]
//                  drawerVisualStateBlockForDrawerSide:drawerSide];
//         if(block){
//             block(drawerController, drawerSide, percentVisible);
//         }
//     }];
//    self.view.window.rootViewController=drawerController;
}

@end