//
//  AppDelegate.m
//  CommonApp
//
//  Created by cheese on 2020/7/24.
//  Copyright © 2020 cheese. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarController.h"
#import "RootViewcontroller.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 设置rootViewController
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [RootTabBarController new];
    
    return YES;
}




@end
