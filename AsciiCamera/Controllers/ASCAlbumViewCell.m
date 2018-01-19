//
//  ASCAlbumViewCell.m
//  AsciiCamera
//
//  Created by 程利 on 2017/12/5.
//  Copyright © 2017年 foundersc. All rights reserved.
//

#import "ASCAlbumViewCell.h"

@implementation ASCAlbumViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];

        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
        [self addSubview:_imageView];
    }

    return self;
}

@end
