//
//  GetDogImageModel.m
//  xiaoA
//
//  Created by qianshi on 16/5/26.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "GetDogImageModel.h"

@implementation GetDogImageModel

-(id)initWithDogImage:(NSString *)dogImage
{
    self = [super init];
    if (self) {
        _dogImage = dogImage;
    }
    return self;
}

@end
