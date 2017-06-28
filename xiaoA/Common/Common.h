//
//  Common.h
//  jiawoshangjia
//
//  Created by qianshi on 16/4/26.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#ifndef Common_h
#define Common_h

//自定义Log
#ifdef DEBUG // 调试状态, 打开LOG功能
#define MyLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define MyLog(...)
#endif


//全局大小
#define KviewWidth [UIScreen mainScreen].bounds.size.width
#define KviewHeight [UIScreen mainScreen].bounds.size.height


//判断设备
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6PBigMode ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)

//颜色
#define KcolorRGB(x,y,z,m) [UIColor colorWithRed:(x/255.0f) green:(y/255.0f)blue:(z/255.0f) alpha:m];

#define KcolorBackRGB ([UIColor colorWithRed:(234/255.0f) green:(80/255.0f)blue:(62/255.0f) alpha:1])

//image
#define ImageCache(image) [UIImage imageNamed:image]


#define KURL @"http://api.jiawoclub.com/" //正式上线环境
#define KURLShang @"http://chezhu.qianshiwang.cn/" //商家

//#define KURL @"http://101.68.90.190:8082/"//预发布环境
//#define KURLShang @"http://test.qianshiwang.cn/" //商家测试环境

#define KregistUrl [NSString stringWithFormat:@"%@cust/register",KURL]//注册
#define KgetAuthCodeUrl [NSString stringWithFormat:@"%@cust/restnotecode",KURL]//获取验证码
#define KgetAuthCodePhoneUrl [NSString stringWithFormat:@"%@cust/verification",KURL]//校验手机号验证码
#define KgetCarInsuranceUrl [NSString stringWithFormat:@"%@port/warranty?",KURLShang]//车险
#define KforgetPassWord [NSString stringWithFormat:@"%@cust/resetpasswd",KURL]//重置密码
#define KInsurePostUrl [NSString stringWithFormat:@"%@port/upload.html?",KURLShang] // 保险上传数据
#define KloginoutUrl [NSString stringWithFormat:@"%@cust/logout",KURL]//退出

//支付
#define Pay_partner @"2088221370176094"
#define Pay_seller @"qiushufan@jiawo.club"
#define Pay_privateKey @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAMW10kzDOWo3T4UxuDmzzHjteSq/sf65gg5idMocgaWlmfgG9Wto4M70WAEz6VzxjfCSRUhPuprl7PerS6oowkPU/6CpRq0bbVMtOOkMVaaYSwdDdPdOp3QaRtyskBKcxxuZX6LxH6ZzG7zVllLhyuWP98sPj4vBuu73+OTTAl0nAgMBAAECgYByA00YCUi10NmhpK9pTx8t6TwDg/JAQ3gVlX9mAhRdkub8Wf7zBtMFZXDOmMINYBsLTT542clxhAAoPvbuVHzZn55TOzZiRAwEX2rsl4pR/I1TVUZoYcq0Du+DYNdsjcECH+wX6LIUX6NEPGErMytm165tiA6yI+L1E6thnnYfIQJBAN3xE8BSOzixPIvWEKaysvx6QqNmiTJisyTlzYAnSJxhoXdV1848kdWlYSTbfx01erF4wwoE8GsYIJ2i1t/twVcCQQDkDNE/IgyaDq2DNr+IxAfuRSe/gjPT6uvhHyz9NFgWGji9X0k5YD0MqZo1JZx/qCIa45mBOLzups9BnZw/H9CxAkAiq8yIGNCDlLx+o9xKDlSDuJ28ZQI9ysltlDC8OmbPdzkAKXrjDvdBRuqcFWYQLBCUtObTI95i/Ivr1Ep5BO1VAkBAS3DPGN1urcazoMLdX09RGQQ81QuhqrD4Fl8LwC85hAkNMwkk+QIdSM/mPgViZFfBNvv3V7TEoBj8yd/cWC7xAkBj5btElAte/L1l6RN7Jc82qkzTHVvbNT/jKhQ28odzHn8snJ2+kQjI62+4/xwMTvQ3+NhGhQQF191CPIw4M7Lj"


// rgb颜色
//全局Color Helper
#define HEXCOLORA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:a]
#define HEXCOLOR(rgbValue) HEXCOLORA(rgbValue, 1.0)
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]
#define RGBA(r,g,b,a) (r)/255.0f, (g)/255.0f, (b)/255.0f, (a)

// 屏幕尺寸
#define JWScreemSize [UIScreen mainScreen].bounds.size
#define JWRectMake(x,y,w,h) CGRectMake(JWScreemSize.width * ((x) / 375.0), JWScreemSize.height * ((y) / 667.0), JWScreemSize.width * ((w) / 375.0), JWScreemSize.height * ((h) / 667.0))

#define JWScaleX(x) JWScreemSize.width * ((x) / 375.0)
#define JWScaleY(y) JWScreemSize.height * ((y) / 667.0)

//NSNull 转 @""
#define checkNull(__X__)        (__X__) == [NSNull null] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]
#endif