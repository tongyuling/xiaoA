//
//  SaveMessageController.m
//  xiaoA
//
//  Created by qianshi on 16/5/25.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "SaveMessageController.h"
#import "Common.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "SetController.h"
#import "ShowImageController.h"
#import "MMProgressHUD.h"
#import "SaveMessageView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "CustomIOSAlertView.h"
#import "UIView+Alert.h"
#import "UIImage+xiaoA.h"
#import "NSString+xiaoA.h"
#import "ZHPickView.h"
#import "DogModel.h"
#import "DogTool.h"
#import "GetDogImageModel.h"
#import "GetDogImageTool.h"

@interface SaveMessageController ()<UITextViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CustomIOSAlertViewDelegate,ZHPickViewDelegate>

@property (nonatomic, strong) SaveMessageView *saveMessageView;
@property (strong,nonatomic) UIImagePickerController * imagePickerController;
@property (nonatomic, strong) CustomIOSAlertView *alert;
@property (nonatomic, strong) ZHPickView *pickView1;
@property (nonatomic, strong) ZHPickView *pickView2;

@end

@implementation SaveMessageController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildUI];
}


-(void)buildUI
{
    self.saveMessageView = [[SaveMessageView alloc]init];
    self.saveMessageView.frame = CGRectMake(0, 0, KviewWidth, KviewHeight);
    [self.view addSubview:self.saveMessageView];
    
    self.saveMessageView.textView.delegate = self;
    self.saveMessageView.textViewP.delegate = self;
    self.saveMessageView.textSex.delegate = self;
    self.saveMessageView.textName.delegate = self;
    self.saveMessageView.textSex.delegate = self;
    self.saveMessageView.textAge.delegate = self;
    self.saveMessageView.textVariety.delegate = self;
    [self.saveMessageView.btn addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.saveMessageView.imageView addGestureRecognizer:tap];
}

#pragma mark 提交 btn
-(void)btn
{
    if ([self.saveMessageView.textName.text isEmptyString] || [self.saveMessageView.textSex.text isEmptyString] || [self.saveMessageView.textVariety.text isEmptyString] || [self.saveMessageView.textAge.text isEmptyString] || [self.saveMessageView.textView.text isEmptyString] || self.saveMessageView.imageView.image == nil) {
        [self.view makeToast:@"请填写完整信息！"];
        return;
    }
    
    // 1.菊花转动
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    
    DogModel * model = [[DogModel alloc]initWithDogName:self.saveMessageView.textName.text dogAge:self.saveMessageView.textAge.text dogVariety:self.saveMessageView.textVariety.text dogSex:self.saveMessageView.textSex.text dogMessage:self.saveMessageView.textView.text];
    [[DogTool sharedDogTool] saveDogModel:model];
    
    [MMProgressHUD showWithTitle:@"提示" status:@"保存成功..."];
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [MMProgressHUD dismiss];
        
        ShowImageController * show = [[ShowImageController alloc]init];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:show];
        self.view.window.rootViewController = nav;
        
    });
}

#pragma mark textfiled_delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.pickView1 remove];
    [self.pickView2 remove];
    
    NSInteger tag = textField.tag;
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    return YES;
}

#pragma mark ZhpickVIewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString
{
    if (pickView == self.pickView1) {
        
        int i = (int)resultString.length;
        NSString * str = [resultString substringWithRange:NSMakeRange(3, i - 3)];
        self.saveMessageView.textVariety.text = str;
        [self.pickView1 remove];
    }
    else if (pickView == self.pickView2)
    {
        self.saveMessageView.textSex.text = resultString;
        [self.pickView2 remove];
    }
}

//通过判断表层TextView的内容来实现底层TextView的显示于隐藏
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if(![text isEqualToString:@""])
    {
        [self.saveMessageView.textViewP setHidden:YES];
    }
    if([text isEqualToString:@""]&&range.length==1&&range.location==0){
        [self.saveMessageView.textViewP setHidden:NO];
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.saveMessageView.frame = CGRectMake(0, -180, KviewWidth, KviewHeight);
    }];
    
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.saveMessageView.frame = CGRectMake(0, 0, KviewWidth, KviewHeight);
    }];
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
    self.saveMessageView.imageView.image = image;
    
    NSString * str = [self UIImageToBase64Str:image];
    GetDogImageModel * model = [[GetDogImageModel alloc]initWithDogImage:str];
    [[GetDogImageTool sharedGetDogImageTool] saveGetDogImageModel:model];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //关闭控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.saveMessageView.frame = CGRectMake(0, 0, KviewWidth, KviewHeight);
    }];
}

#pragma mark 图片转字符串
-(NSString *)UIImageToBase64Str:(UIImage *)image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

@end
