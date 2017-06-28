//
//  ShowViewCell.m
//  xiaoA
//
//  Created by qianshi on 16/6/27.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "ShowViewCell.h"
#import "UIView+Layout.h"

@implementation ShowViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        self.clipsToBounds = YES;
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"发布话题删除图片"] forState:UIControlStateNormal];
        _deleteBtn.frame = CGRectMake(self.tz_width - 30, 0, 30, 30);
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -10);
        [self addSubview:_deleteBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}

- (void)setRow:(NSInteger)row {
    _row = row;
    _deleteBtn.tag = row;
}


@end
