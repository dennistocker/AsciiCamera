//
//  ASCAppDelegate.m
//  AsciiCamera
//
//  Created by 程利 on 2017/12/4.
//  Copyright © 2017年 foundersc. All rights reserved.
//

#import "ASCAppDelegate.h"
#import "ASCTabBarController.h"

@implementation ASCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] init];
    self.window.rootViewController = [[ASCTabBarController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}

@end
