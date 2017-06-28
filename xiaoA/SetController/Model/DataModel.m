//
//  DataModel.m
//  xiaoA
//
//  Created by qianshi on 16/6/1.
//  Copyright © 2016年 chenlingang. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.time forKey:@"dataTime"];
    [aCoder encodeObject:self.message forKey:@"dataMessage"];
    [aCoder encodeObject:self.image1 forKey:@"dataImage1"];
    [aCoder encodeObject:self.image2 forKey:@"dataImage2"];
    [aCoder encodeObject:self.image3 forKey:@"dataImage3"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.time = [aDecoder decodeObjectForKey:@"dataTime"];
        self.message = [aDecoder decodeObjectForKey:@"dataMessage"];
        self.image1 = [aDecoder decodeObjectForKey:@"dataImage1"];
        self.image2 = [aDecoder decodeObjectForKey:@"dataImage2"];
        self.image3 = [aDecoder decodeObjectForKey:@"dataImage3"];
    }
    return self;
}

@end
