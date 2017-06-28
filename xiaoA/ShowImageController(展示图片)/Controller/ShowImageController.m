//
//  ShowImageController.m
//  xiaoA
//
//  Created by qianshi on 16/5/23.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "ShowImageController.h"
#import "Common.h"
#import "GetNumberPlistTool.h"
#import "GetNumberPlistModel.h"
#import "NSString+xiaoA.h"
#import "DWFlowLayout.h"
#import "DWViewCell.h"
#import "ShowSelectController.h"
#import "HMSideMenu.h"
#import "ShowController.h"
#import "MessageController.h"
#import "CustomIOSAlertView.h"
#import "MMProgressHUD.h"
#import "UMSocial.h"
#import "LoginTool.h"
#import "LoginModel.h"
#import "GuideController.h"
#import "PlayController.h"

@interface ShowImageController ()<UICollectionViewDataSource, UICollectionViewDelegate,CustomIOSAlertViewDelegate>

@property (nonatomic, strong) UICollectionView *collect;
@property (nonatomic, strong) NSMutableArray *imageData;
@property (nonatomic, strong) NSMutableArray *numberData;
@property (nonatomic, strong) NSMutableArray *playImageData;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) HMSideMenu *sideMenu;
@property (nonatomic, strong) CustomIOSAlertView *alert;
@property (nonatomic, strong) UILabel *label;

@end

@implementation ShowImageController

- (void)viewWillAppear:(BOOL)animated
{
    if (self.sideMenu.isOpen){
        [self.sideMenu close];
    }
    
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIColor * color = KcolorBackRGB;
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.imageData = [NSMutableArray array];
    self.playImageData = [NSMutableArray array];
    self.numberData = [NSMutableArray array];
    
    self.navigationItem.title = @"Showtime";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    //@{UITextAttributeTextColor: [UIColor whiteColor]};
    self.navigationController.navigationBar.alpha = 0.8;
    [self.navigationController.navigationBar setBackgroundColor:color];
    
    //右导航按钮
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"play" style:UIBarButtonItemStylePlain target:self action:@selector(btnRight)];
    rightBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    //去掉导航栏下面的黑线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    //创建一个高20的假状态栏背景
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, KviewWidth, 20)];
    statusBarView.backgroundColor=color;
    [self.navigationController.navigationBar addSubview:statusBarView];
    
    [self buildUI];
    
    // 通知中心
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goChangeImage:) name:@"showImage" object:nil];
}


#pragma mark 通知中心方法
-(void)goChangeImage:(NSNotification *)notification
{
    if (self.label.hidden == NO) {
        self.label.hidden = YES;
    }
    
    //拿到通知内容
    NSDictionary * dic = [notification userInfo];
    NSString * str=[NSString stringWithFormat:@"%@",[dic objectForKey:@"showImageNumber"]];
    self.number = str;
    [self loadData];
    [self.collect reloadData];
}


-(void)buildUI
{
//    UIColor * color = KcolorBackRGB ;
    
    [self loadData];
    
    DWFlowLayout *layout = [[DWFlowLayout alloc] init];
    //设置是否需要分页
    [layout setPagingEnabled:YES];
    self.collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KviewWidth, KviewHeight) collectionViewLayout:layout];
    [self.collect registerClass:[DWViewCell class] forCellWithReuseIdentifier:@"cellID"];
    self.collect.delegate = self;
    self.collect.dataSource = self;
    self.collect.showsHorizontalScrollIndicator = NO;
    [self.collect reloadData];
    self.collect.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collect];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(KviewWidth - 40, KviewHeight - 40, 30, 30);
    [self.btn setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    //拖动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pantoBtn:)];
    [self.btn addGestureRecognizer:pan];
    [self.btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    
    self.label = [[UILabel alloc]init];
    self.label.numberOfLines = 0;
    self.label.center = CGPointMake(KviewWidth/2, KviewHeight/2 - 20);
    self.label.bounds = CGRectMake(0, 0, 120, 100);
    self.label.font = [UIFont systemFontOfSize:15];
    self.label.hidden = YES;
    self.label.text = @"您还没有给爱犬发布动态，赶快发布吧！";
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];

    if ([[GetNumberPlistTool sharedGetNumberPlistTool].getNumberPlistModel.numberPlist isEqualToString:@"0"]) {
        self.label.hidden = NO;
    }
    
    [self addSideMenuUI];
}

#pragma mark 拖动手势
-(void)pantoBtn:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan locationInView:self.view];
    
    self.btn.center = point;
    
    if (([(UIPanGestureRecognizer *)pan state] == UIGestureRecognizerStateEnded )||([(UIPanGestureRecognizer *)pan state] == UIGestureRecognizerStateCancelled)){
        
            CGFloat x = pan.view.center.x;
            CGFloat y = pan.view.center.y;
            
            if (x > KviewWidth / 2.0) {
                x = KviewWidth - 30;
            }else {
                x = 30;
            }
 
            if (y > KviewHeight - 50) {
                y = KviewHeight - 30;
            }else if (y < 66) {
                y = 30;
            }
            CGFloat velocityX = (0.2 * [pan velocityInView:self.view].x);

            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:ABS(velocityX * 0.00002 + 0.2)];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            
            pan.view.center = CGPointMake(x, y);
            
            [UIView commitAnimations];
        }
}


-(void)addSideMenuUI
{
    UIView *oneItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [oneItem setMenuActionWithBlock:^{
        MessageController * message = [[MessageController alloc]init];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:message];
        [self presentViewController:nav animated:YES completion:nil];
    }];
    UIImageView *oneIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, 35, 35)];
    oneIcon.backgroundColor = [UIColor orangeColor];
    [oneItem addSubview:oneIcon];
    
    UIView *twoItem = [[UIView alloc] initWithFrame:CGRectMake(oneItem.frame.origin.x, oneItem.frame.origin.y, oneItem.frame.size.width, oneItem.frame.size.height)];
    [twoItem setMenuActionWithBlock:^{
        ShowController * show = [[ShowController alloc]init];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:show];
        [self presentViewController:nav animated:YES completion:nil];
    }];
    UIImageView *twoIcon = [[UIImageView alloc] initWithFrame:CGRectMake(oneIcon.frame.origin.x, oneIcon.frame.origin.y, oneIcon.frame.size.width, oneIcon.frame.size.height)];
    twoIcon.backgroundColor = [UIColor purpleColor];
    [twoItem addSubview:twoIcon];
    
    UIView *threeItem = [[UIView alloc] initWithFrame:CGRectMake(oneItem.frame.origin.x, oneItem.frame.origin.y, oneItem.frame.size.width, oneItem.frame.size.height)];
    [threeItem setMenuActionWithBlock:^{
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
    }];
    UIImageView *threeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(oneIcon.frame.origin.x, oneIcon.frame.origin.y, oneIcon.frame.size.width, oneIcon.frame.size.height)];
    threeIcon.backgroundColor = [UIColor redColor];
    [threeItem addSubview:threeIcon];
    
    self.sideMenu = [[HMSideMenu alloc] initWithItems:@[oneItem, twoItem, threeItem]];
    self.sideMenu.itemSpacing = 15;
    self.sideMenu.menuPosition = HMSideMenuPositionBottom;
    [self.view addSubview:self.sideMenu];
}

-(void)tap
{
    [self.alert close];
}

#pragma mark alertview自定义总的内容
-(UIView *)createView:(NSString *)message
{
    if (self.sideMenu.isOpen){
        [self.sideMenu close];
    }
    
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

-(void)btn:(UIButton *)btn
{
    if (self.sideMenu.isOpen)
        [self.sideMenu close];
    else
        [self.sideMenu open];
}

-(void)loadData
{
    [self.numberData removeAllObjects];
    [self.imageData removeAllObjects];
    [self.playImageData removeAllObjects];
    
    int number = [[GetNumberPlistTool sharedGetNumberPlistTool].getNumberPlistModel.numberPlist intValue];
    
    //for (int i = 0; i < number; i++) {
    for (int i = number; i > 0 ; i--) {
       
        NSData * data = [[NSData alloc] initWithContentsOfFile:[self getFilePathWithModelKey:[NSString stringWithFormat:@"test%d",i]]]; // +1
        //解档辅助类
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        //解码并解档出model
        if ([[unarchiver decodeObjectForKey:@"dataImage2"]isEmptyString]) {
            [self.imageData addObject:[unarchiver decodeObjectForKey:@"dataImage1"]];
            [self.playImageData addObject:[unarchiver decodeObjectForKey:@"dataImage1"]];
            
            self.number = @"1";
        }
        else if([[unarchiver decodeObjectForKey:@"dataImage3"]isEmptyString]){
            [self.imageData addObject:[unarchiver decodeObjectForKey:@"dataImage1"]];
//            [self.imageData addObject:[unarchiver decodeObjectForKey:@"dataImage2"]];
            [self.playImageData addObject:[unarchiver decodeObjectForKey:@"dataImage1"]];
            [self.playImageData addObject:[unarchiver decodeObjectForKey:@"dataImage2"]];
            
            self.number = @"2";
        }
        else{
            [self.imageData addObject:[unarchiver decodeObjectForKey:@"dataImage1"]];
//            [self.imageData addObject:[unarchiver decodeObjectForKey:@"dataImage2"]];
//            [self.imageData addObject:[unarchiver decodeObjectForKey:@"dataImage3"]];
            [self.playImageData addObject:[unarchiver decodeObjectForKey:@"dataImage1"]];
            [self.playImageData addObject:[unarchiver decodeObjectForKey:@"dataImage2"]];
            [self.playImageData addObject:[unarchiver decodeObjectForKey:@"dataImage3"]];
            
            self.number = @"3";
        }
        //关闭解档
        [unarchiver finishDecoding];
        
        [self.numberData addObject:self.number];
    }
}

//得到Document目录
-(NSString *) getFilePathWithModelKey:(NSString *)modelkey
{
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[array objectAtIndex:0] stringByAppendingPathComponent:modelkey];
}

#pragma mark cell的数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.numberData.count;
}

#pragma mark cell的视图
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cellID";
    DWViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UIImage * image = [self Base64StrToUIImage:[self.imageData objectAtIndex:indexPath.row]];

    if (CGImageGetHeight(image.CGImage) >= 568) {
        cell.showImg.frame = CGRectMake(0, 0, KviewWidth - 60, KviewHeight - 64 - 120);
    }else{
        cell.showImg.frame = CGRectMake(0, 5, KviewWidth - 60, KviewHeight - 64 - 240);
    }
    cell.showImg.image = image;
    cell.labelNumber.text = self.numberData[indexPath.row];
    
    
    return cell;
}

#pragma mark cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIImage * image = [self Base64StrToUIImage:[self.imageData objectAtIndex:indexPath.row]];

    if (CGImageGetHeight(image.CGImage) >= 568) {
        return CGSizeMake(KviewWidth - 60, KviewHeight - 64 - 120);
    }else{
        return CGSizeMake(KviewWidth - 60, KviewHeight - 64 - 240);
    }
}

#pragma mark cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    DWViewCell *cell = (DWViewCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    ShowSelectController * select = [[ShowSelectController alloc]init];
    select.number = [NSString stringWithFormat:@"%ld",indexPath.row];
    [self.navigationController pushViewController:select animated:YES];
}

#pragma mark 字符串转图片
-(UIImage *)Base64StrToUIImage:(NSString *)encodedImageStr
{
    NSData * decodedImageData = [[NSData alloc]initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}

#pragma mark 右导航按钮
-(void)btnRight
{
    PlayController * play = [[PlayController alloc]init];
    play.playImageData = [self.playImageData copy];
    [self.navigationController pushViewController:play animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
