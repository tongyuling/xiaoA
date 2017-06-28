//
//  ShowController.m
//  xiaoA
//
//  Created by qianshi on 16/5/27.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "ShowController.h"
#import "Common.h"
#import "ShowView.h"
#import "UIView+Alert.h"
#import "NSString+xiaoA.h"
#import "UIImage+xiaoA.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "GetNumberPlistTool.h"
#import "GetNumberPlistModel.h"
#import "MMProgressHUD.h"
#import "ZLPhotoActionSheet.h"
#import "ZLShowBigImage.h"
#import "ZLDefine.h"
#import "ZLCollectionCell.h"

#import "TZImageManager.h"
#import "UIView+Layout.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImagePickerController.h"
#import "ShowViewCell.h"

@interface ShowController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TZImagePickerControllerDelegate>
{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
}

@property (nonatomic, strong) ShowView *showView;
@property (nonatomic, strong) NSArray<ZLSelectPhotoModel *> *lastSelectMoldels;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arrDataSources;
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIImageView *imageView3;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, assign) int i; // 判断是第几个imageview

@end

@implementation ShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"爱犬动态";
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
    
    //右导航按钮
    UIBarButtonItem * rightBtn=[[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(addBtn)];
    rightBtn.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    [self buildUI];
}


-(void)buildUI
{
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    
    self.showView = [[ShowView alloc]initWithFrame:CGRectMake(0, 64, KviewWidth, 115)];
    [self.view addSubview:self.showView];
    self.showView.backgroundColor = [UIColor whiteColor];
    self.showView.textView.delegate = self;
    self.showView.textViewP.delegate = self;
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(70, 70);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.showView.frame)+10, KviewWidth - 90, 70) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[ShowViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [self.view addSubview:self.collectionView];
    
    self.label = [[UILabel alloc]init];
    self.label.frame = CGRectMake(self.collectionView.frame.origin.x, CGRectGetMaxY(self.collectionView.frame)+15, KviewWidth, 10);
    self.label.text = @"最多支持发布3张图片";
    self.label.textColor = [UIColor lightGrayColor];
    self.label.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:self.label];
}
#pragma mark 添加图片按钮方法
- (void)pickPhotoButtonClick:(UIButton *)sender {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVc.maxImagesCount = 3;
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    imagePickerVc.selectedAssets = _selectedAssets; // optional, 可选的
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (_selectedPhotos.count == 3) {
        return 3;
    }
    return _selectedPhotos.count + 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShowViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"addImage"];
        cell.deleteBtn.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        [self pickPhotoButtonClick:nil];
    } else { // preview photos / 预览照片
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
        imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
        // imagePickerVc.allowPickingOriginalPhoto = NO;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            _selectedPhotos = [NSMutableArray arrayWithArray:photos];
            _selectedAssets = [NSMutableArray arrayWithArray:assets];
            _isSelectOriginalPhoto = isSelectOriginalPhoto;
            //            _layout.itemCount = _selectedPhotos.count;
            [_collectionView reloadData];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}
- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.item >= _selectedPhotos.count || destinationIndexPath.item >= _selectedPhotos.count) return;
    UIImage *image = _selectedPhotos[sourceIndexPath.item];
    if (image) {
        [_selectedPhotos exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        [_selectedAssets exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        [_collectionView reloadData];
    }
}

#pragma mark Click Event
- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    //    _layout.itemCount = _selectedPhotos.count;
    
    [_collectionView performBatchUpdates:^{
        if (_selectedPhotos.count != 2) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
            [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
        }
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}

#pragma mark TZImagePickerControllerDelegate
/// 用户点击了取消
- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}
/// 用户选择好了图片，如果assets非空，则用户选择了原图。
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [self.collectionView reloadData];
}
/// 用户选择好了视频
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    // open this code to send video / 打开这段代码发送视频
    // [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
    // NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
    // Export completed, send video here, send by outputPath or NSData
    // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    
    // }];
    [_collectionView reloadData];
}

//通过判断表层TextView的内容来实现底层TextView的显示于隐藏
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        if (range.location == 0) {
            [self.showView.textViewP setHidden:NO];
        }
        
        [textView resignFirstResponder];
        return NO;
    }
    if(![text isEqualToString:@""])
    {
        [self.showView.textViewP setHidden:YES];
    }
    if([text isEqualToString:@""]&&range.length==1&&range.location==0){
        [self.showView.textViewP setHidden:NO];
    }
    
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark 发布 btn 方法
-(void)addBtn
{
    [self.view endEditing:YES];
    
    if (_selectedPhotos.count == 0) {
        [self.view makeToast:@"最少要发布一张图片"];
        return;
    }
    
    // 1.菊花转动
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * dateTime = [formatter stringFromDate:[NSDate date]];
    
    //获取plist的数字
    int i = [[GetNumberPlistTool sharedGetNumberPlistTool].getNumberPlistModel.numberPlist intValue];
    NSString * str = [NSString stringWithFormat:@"%d",i + 1];
    GetNumberPlistModel * model = [[GetNumberPlistModel alloc]initWithNumberPlist:str];
    [[GetNumberPlistTool sharedGetNumberPlistTool] saveGetNumberPlistModel:model];
    
    
    NSMutableData *data = [[NSMutableData alloc] init];
    //创建归档辅助类
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //编码
    [archiver encodeObject:dateTime forKey:@"dataTime"];
    [archiver encodeObject:self.showView.textView.text forKey:@"dataMessage"];
    
    if (_selectedPhotos.count == 1) {
        [archiver encodeObject:[self UIImageToBase64Str:_selectedPhotos[0]] forKey:@"dataImage1"];
        [archiver encodeObject:@"" forKey:@"dataImage2"];
        [archiver encodeObject:@"" forKey:@"dataImage3"];
    }
    else if (_selectedPhotos.count == 2){
        [archiver encodeObject:[self UIImageToBase64Str:_selectedPhotos[0]] forKey:@"dataImage1"];
        [archiver encodeObject:[self UIImageToBase64Str:_selectedPhotos[1]] forKey:@"dataImage2"];
        [archiver encodeObject:@"" forKey:@"dataImage3"];
    }
    else{
        [archiver encodeObject:[self UIImageToBase64Str:_selectedPhotos[0]] forKey:@"dataImage1"];
        [archiver encodeObject:[self UIImageToBase64Str:_selectedPhotos[1]] forKey:@"dataImage2"];
        [archiver encodeObject:[self UIImageToBase64Str:_selectedPhotos[2]] forKey:@"dataImage3"];
    }
    //结束编码
    [archiver finishEncoding];
    //写入
    [data writeToFile:[self getFilePathWithModelKey:[NSString stringWithFormat:@"test%@",str]] atomically:YES];
    
    [MMProgressHUD showWithTitle:@"提示" status:@"发布成功..."];
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [MMProgressHUD dismiss];
        //发通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"fabu" object:self];
        
        if (_selectedPhotos.count == 1) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"showImage" object:nil userInfo:@{@"showImageNumber":@"1"}];
        }
        else if (_selectedPhotos.count == 2){
            [[NSNotificationCenter defaultCenter]postNotificationName:@"showImage" object:nil userInfo:@{@"showImageNumber":@"2"}];
        }
        else{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"showImage" object:nil userInfo:@{@"showImageNumber":@"3"}];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    });

}


//得到Document目录
-(NSString *) getFilePathWithModelKey:(NSString *)modelkey
{
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[array objectAtIndex:0] stringByAppendingPathComponent:modelkey];
}


-(void)backBtn
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 图片转字符串
-(NSString *)UIImageToBase64Str:(UIImage *)image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
