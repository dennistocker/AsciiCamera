//
//  ASCAlbumTransition.h
//  AsciiCamera
//
//  Created by 程利 on 2017/12/5.
//  Copyright © 2017年 foundersc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCAlbumTransition : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithInverse:(BOOL)inverse;

@end
