//
//  MessageController.m
//  xiaoA
//
//  Created by qianshi on 16/5/24.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "MessageController.h"
#import "Common.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "MessageView.h"
#import "CustomIOSAlertView.h"
#import "UIView+Alert.h"
#import "UIImage+xiaoA.h"
#import "NSString+xiaoA.h"
#import "DogModel.h"
#import "DogTool.h"
#import "GetDogImageModel.h"
#import "GetDogImageTool.h"
#import "DogTool.h"
#import "DogModel.h"
#import "MMProgressHUD.h"
#import "ZHPickView.h"

@interface MessageController ()<CustomIOSAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate,UITextFieldDelegate,ZHPickViewDelegate>

@property (nonatomic, strong) MessageView *messageView;
@property (nonatomic, strong) CustomIOSAlertView *alert;
@property (strong,nonatomic) UIImagePickerController * imagePickerController;
@property (nonatomic) BOOL isEdit;
@property (nonatomic, strong) ZHPickView *pickView1;
@property (nonatomic, strong) ZHPickView *pickView2;

@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"我的爱犬信息";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    //@{UITextAttributeTextColor: [UIColor whiteColor]};
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
    
    //右导航按钮
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(btnRight)];
    rightBtn.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    [self buildUI];
}


-(void)buildUI
{
    self.messageView = [[MessageView alloc]init];
    self.messageView.frame = CGRectMake(0, 0, KviewWidth, KviewHeight);
    [self.view addSubview:self.messageView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.messageView.imageView addGestureRecognizer:tap];
    self.messageView.textView.delegate = self;
    self.messageView.textSex.delegate = self;
    self.messageView.textAge.delegate = self;
    self.messageView.textVariety.delegate = self;
    self.messageView.textName.delegate = self;
    
    //赋值
    self.messageView.textName.text = [DogTool sharedDogTool].dogModel.dogName;
    self.messageView.textAge.text = [DogTool sharedDogTool].dogModel.dogAge;
    self.messageView.textVariety.text = [DogTool sharedDogTool].dogModel.dogVariety;
    self.messageView.textSex.text = [DogTool sharedDogTool].dogModel.dogSex;
    self.messageView.textView.text = [DogTool sharedDogTool].dogModel.dogMessage;
}

//懒加载
-(UIImagePickerController *)imagePickerController
{
    //判断是否已经有了，若没有，则进行实例化
    if (!_imagePickerController) {
        _imagePickerController=[[UIImagePickerController alloc]init];
    }
    return _imagePickerController;
}

-(void)tap
{
    //创建alert
    self.alert=[[CustomIOSAlertView alloc]init];
    UITapGestureRecognizer * tapClose = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClose)];
    [self.alert addGestureRecognizer:tapClose];
    //加入自定义总的内容
    [self.alert setContainerView:[self createView:@"请选择头像的来源方式"]];
    //button
    [self.alert setButtonTitles:@[@"拍照",@"相册"]];
    [self.alert setDelegate:self];
    //展示alertview
    [self.alert show];
}

-(void)tapClose{
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
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        if (buttonIndex==0) {
            // 拍照
            self.imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
            // 显示照片选择控制器
            [self presentViewController:self.imagePickerController animated:YES completion:nil];
            //关闭alertview
            [alertView close];
        }
    }
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        if (buttonIndex==1) {
            // 相册
            self.imagePickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            // 显示照片选择控制器
            [self presentViewController:self.imagePickerController animated:YES completion:nil];
            //关闭alertview
            [alertView close];
        }
    }
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        if (buttonIndex==0) {
            
            [self.view makeToast:@"此设备不支持拍照功能"];
            //关闭alertview
            [alertView close];
        }
    }
    // 允许编辑
    self.imagePickerController.allowsEditing=YES;
    // 设置代理
    self.imagePickerController.delegate=self;
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        
        self.imagePickerController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    }
    //关闭alertview
    [alertView close];
}

#pragma mark UIImagePickerController代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //1.关闭控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString* type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:(NSString*)kUTTypeImage] && picker.sourceType==UIImagePickerControllerSourceTypeCamera) {
        
        UIImage *image0=[info objectForKey:UIImagePickerControllerOriginalImage];
        // 保存图片到相册
        UIImageWriteToSavedPhotosAlbum(image0, nil, nil, nil);
    }
    
    //设置图片
    UIImage * image = [UIImage imageWithImageSimple:[info objectForKey:UIImagePickerControllerEditedImage] scaledToSize:CGSizeMake(100, 100)];
    self.messageView.imageView.image = image;
    
    //保存
    NSString * str = [self UIImageToBase64Str:image];
    GetDogImageModel * model = [[GetDogImageModel alloc]initWithDogImage:str];
    [[GetDogImageTool sharedGetDogImageTool] saveGetDogImageModel:model];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //关闭控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 右导航按钮
-(void)btnRight
{
    UIBarButtonItem * leftBtn=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtn)];
    leftBtn.tintColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UIBarButtonItem * rightBtn=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(updataBtn)];
    rightBtn.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    self.isEdit=YES;
    [self.messageView.textName becomeFirstResponder];
}

#pragma mark 保存按钮方法
-(void)updataBtn
{
    [self.view endEditing:YES];
    
    self.isEdit=NO;
    
    if ([self.messageView.textName.text isEmptyString] || [self.messageView.textSex.text isEmptyString] || [self.messageView.textVariety.text isEmptyString] || [self.messageView.textAge.text isEmptyString] || [self.messageView.textView.text isEmptyString] || self.messageView.imageView.image == nil) {
        [self.view makeToast:@"请填写完整信息！"];
        
        self.isEdit=YES;
        
        return;
    }
    
    // 1.菊花转动
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    
    DogModel * model = [[DogModel alloc]initWithDogName:self.messageView.textName.text dogAge:self.messageView.textAge.text dogVariety:self.messageView.textVariety.text dogSex:self.messageView.textSex.text dogMessage:self.messageView.textView.text];
    [[DogTool sharedDogTool] saveDogModel:model];
    
    GetDogImageModel * m = [[GetDogImageModel alloc]initWithDogImage:[self UIImageToBase64Str:self.messageView.imageView.image]];
    [[GetDogImageTool sharedGetDogImageTool] saveGetDogImageModel:m];
    
    [MMProgressHUD showWithTitle:@"提示" status:@"保存成功..."];
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [MMProgressHUD dismiss];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

#pragma mark 点击取消方法
-(void)cancelBtn
{
    [self.view endEditing:YES];
    
    UIBarButtonItem * rightBtn=[[UIBarButtonItem alloc]initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(btnRight)];
    rightBtn.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    UIBarButtonItem * leftBtn=[[UIBarButtonItem alloc]initWithImage:ImageCache(@"返回image") style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];
    leftBtn.tintColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    self.isEdit = NO;
}

#pragma mark textfiled_delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.pickView1 remove];
    [self.pickView2 remove];
    
    NSInteger tag = textField.tag;
    
    if (self.isEdit==YES) {
        
        if(tag ==12){
            
            [self.view endEditing:YES];
            
            self.pickView1=[[ZHPickView alloc] initPickviewWithPlistName:@"dog" isHaveNavControler:NO];
            self.pickView1.delegate = self;
            [self.pickView1 show];
            
            return NO;
        }
        else if(tag ==13){
            
            [self.view endEditing:YES];
            
            self.pickView2=[[ZHPickView alloc] initPickviewWithPlistName:@"sex" isHaveNavControler:NO];
            self.pickView2.delegate = self;
            [self.pickView2 show];
            
            return NO;
        }
        else{
            return YES;
        }
    }
    else{
        return NO;
    }
}

#pragma mark ZhpickVIewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString
{
    if (pickView == self.pickView1) {
        
        int i = (int)resultString.length;
        NSString * str = [resultString substringWithRange:NSMakeRange(3, i - 3)];
        self.messageView.textVariety.text = str;
        [self.pickView1 remove];
    }
    else if (pickView == self.pickView2)
    {
        self.messageView.textSex.text = resultString;
        [self.pickView2 remove];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.messageView.frame = CGRectMake(0, -180, KviewWidth, KviewHeight);
    }];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.messageView.frame = CGRectMake(0, 0, KviewWidth, KviewHeight);
    }];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.messageView.frame = CGRectMake(0, 0, KviewWidth, KviewHeight);
    }];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)backBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 图片转字符串
-(NSString *)UIImageToBase64Str:(UIImage *)image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

@end
