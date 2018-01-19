//
//  ASCAlbumHeaderView.m
//  AsciiCamera
//
//  Created by 程利 on 2017/12/5.
//  Copyright © 2017年 foundersc. All rights reserved.
//

#import "ASCAlbumHeaderView.h"

@implementation ASCAlbumHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(frame)-40, CGRectGetHeight(frame))];
        [self addSubview:_timeLabel];
    }
    return self;
}
@end
