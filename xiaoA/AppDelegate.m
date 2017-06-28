//
//  AppDelegate.m
//  xiaoA
//
//  Created by qianshi on 16/5/23.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"
#import "GuideController.h"
#import "GuideModel.h"
#import "GuideTool.h"
#import "ShowImageController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"
#import <QuartzCore/QuartzCore.h>
#import "Common.h"
#import "SetController.h"
#import "LoginTool.h"
#import "LoginModel.h"
#import "SaveMessageController.h"
#import "GetNumberPlistModel.h"
#import "GetNumberPlistTool.h"
#import "DogTool.h"
#import "DogModel.h"
#import "ShowImageController.h"
#import "AFNetworking.h"

@interface AppDelegate ()<CLLocationManagerDelegate>

@property(nonatomic,retain)CLLocationManager *locationManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [UMSocialData setAppKey:@"5742bce767e58eaf01001404"];
    
    //设置微信AppId、appSecret，分享url                               
    [UMSocialWechatHandler setWXAppId:@"wx8f01fe144a7bbdf6" appSecret:@"a824748da732e51f426640c6fb43dbc8" url:@"itunes.apple.com/cn/app/id1049232611?mt=8"];
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"879073411" secret:@"520e4169ec305767b42b4479947f0529" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    //设置分享到QQ/Qzone的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"1105346051" appKey:@"xKDbxhzi2YW7GyDB" url:@"http://zyiqing123@sina.com"];
    
    [UMSocialQQHandler setSupportWebView:YES];
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
    
    //开始定位
    [self startLocation];
    
    // 设置状态栏的颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    
    NSString *key = (NSString *)kCFBundleVersionKey;
    //1.从Info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    //2.从沙盒中取出版本号
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    //3.页面跳转
    if ([version isEqualToString:saveVersion])
    {
        //*************（登录一次记住账号和密码）**************
        NSString * name = [LoginTool sharedLoginTool].loginModel.loginName;
        
        if (name == nil && [DogTool sharedDogTool].dogModel.dogVariety == nil) {
            GuideController * guide = [[GuideController alloc]init];
            guide.number = 10000;
            self.window.rootViewController = guide;
        }
        else
        {
            if ([DogTool sharedDogTool].dogModel.dogVariety != nil) {
//                UIViewController * left = [[SetController alloc] init];
//                UIViewController * center = [[ShowImageController alloc] init];
//                
//                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:center];
//                
//                MMDrawerController * drawerController = [[MMDrawerController alloc]
//                                                         initWithCenterViewController:nav
//                                                         leftDrawerViewController:left
//                                                         rightDrawerViewController:nil];
//                [drawerController setMaximumRightDrawerWidth:KviewWidth/1.16];
//                [drawerController setMaximumLeftDrawerWidth:KviewWidth/1.16];
//                
//                [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
//                [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
//                
//                [drawerController
//                 setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
//                     MMDrawerControllerDrawerVisualStateBlock block;
//                     block = [[MMExampleDrawerVisualStateManager sharedManager]
//                              drawerVisualStateBlockForDrawerSide:drawerSide];
//                     if(block){
//                         block(drawerController, drawerSide, percentVisible);
//                     }
//                 }];
//                self.window.rootViewController=drawerController;
                
                ShowImageController * show = [[ShowImageController alloc]init];
                UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:show];
                self.window.rootViewController = nav;
            }
            else{
                SaveMessageController * message = [[SaveMessageController alloc]init];
                self.window.rootViewController = message;
            }
        }
    }
    else
    {
        GetNumberPlistModel * model = [[GetNumberPlistModel alloc]initWithNumberPlist:@"0"];
        [[GetNumberPlistTool sharedGetNumberPlistTool] saveGetNumberPlistModel:model];
        
        //如果没有版本号，就把版本号储存，立即储存
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        GuideController * guide = [[GuideController alloc]init];
        guide.number = 10000;
        self.window.rootViewController = guide;
    }
    
    //延长启动图的持续时间
    [NSThread sleepForTimeInterval:1.0];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


-(void)applicationDidBecomeActive:(UIApplication*)application
{
    [UMSocialSnsService applicationDidBecomeActive];
}

-(BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)url
{
    return [UMSocialSnsService handleOpenURL:url];
}

-(BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation
{
    return [UMSocialSnsService handleOpenURL:url];
}


//开始定位
- (void)startLocation
{
    if (nil == _locationManager)
        
        _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    //设置定位的精度
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置移动多少距离后,触发代理.
    _locationManager.distanceFilter = 10;
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0)
    {
        [_locationManager requestWhenInUseAuthorization];// 前台定位
        [_locationManager requestAlwaysAuthorization];// 前后台同时定位
    }
    
    // 开始定位
    [self.locationManager startUpdatingLocation];
}


#pragma mark - CoreLocation Delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = locations[0];
    
    NSString *latitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];

    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error){
        NSString * addressString;
        if (array.count > 0)
        {
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            addressString = [NSString stringWithFormat:@"%@",placemark.name];
            GuideModel * model = [[GuideModel alloc]initWithJingDu:latitude weiDu:longitude address:addressString];
            [[GuideTool sharedGuideTool] saveGuideModel:model];
        }
    }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
