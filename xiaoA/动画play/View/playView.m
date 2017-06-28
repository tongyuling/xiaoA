//
//  playView.m
//  xiaoA
//
//  Created by tyl on 17/6/27.
//  Copyright © 2017年 chenlingang. All rights reserved.
//

#import "playView.h"
#import "playImageView.h"
#import "playTool.h"

@implementation playView

- (instancetype)initWithFrame:(CGRect)frame imageNameArr:(NSArray *)imageArr imageSize:(CGSize)imageSize
{
    self = [super initWithFrame:frame];
    
    if (self) {
        int imgNumber = frame.size.width /imageSize.width;
        
        for (int i = 0; i < imageArr.count; i ++) {
            
            playImageView *playImage = [[playImageView alloc] initWithFrame:CGRectMake(imageSize.width *(i % imgNumber), imageSize.height *(i / imgNumber), imageSize.width, imageSize.height) imageName:imageArr[i]];
            playImage.tag = 100 +i;
            playImage.userInteractionEnabled = YES;
            [self addSubview:playImage];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
            [playImage addGestureRecognizer:tap];
            
            
            playTool *tool = [playTool sharePlayTool];
            
            [tool addAimView:playImage referenceView:self];
        }
    }
    return self;
}

- (void)imageClick:(UITapGestureRecognizer *)tap{
    
    if (self.clickImageBlock) {
        
        self.clickImageBlock((int)tap.view.tag -100);
    }
}

@end
