//
//  ASCTabBarController.m
//  AsciiCamera
//
//  Created by 程利 on 2017/12/4.
//  Copyright © 2017年 foundersc. All rights reserved.
//

#import "ASCTabBarController.h"
#import "ASCAlbumViewController.h"
#import "ASCCameraViewController.h"
#import "ASCSettingsViewController.h"

@interface ASCTabBarController ()

@end

@implementation ASCTabBarController

//@synthesize testString=_testString;
//@synthesize testString;
//@dynamic testString;

- (void)setTestString:(NSString *)testString
{
    _testString = testString;
}

//- (NSString *)testString
//{
//    return _testString;
//}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupViewControllers];
    }
    return self;
}

- (void)setupViewControllers
{
    ASCAlbumViewController *vc1 = [[ASCAlbumViewController alloc] init];
    vc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"home" image:[UIImage imageNamed:@"home"] selectedImage:nil];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc1];
    vc1.navigationItem.title = @"图片";
    [self addChildViewController:navVC];

    ASCCameraViewController *vc2 = [[ASCCameraViewController alloc] init];
    vc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"add" image:[UIImage imageNamed:@"add"] selectedImage:nil];
    [self addChildViewController:vc2];

    ASCSettingsViewController *vc3 = [[ASCSettingsViewController alloc] init];
    vc3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"settings" image:[UIImage imageNamed:@"settings"] selectedImage:nil];
    [self addChildViewController:vc3];
}




@end
