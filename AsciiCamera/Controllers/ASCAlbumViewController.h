//
//  ASCAlbumViewController.h
//  AsciiCamera
//
//  Created by 程利 on 2017/12/4.
//  Copyright © 2017年 foundersc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCAlbumViewController : UIViewController

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) CGRect cellRect;

@end
