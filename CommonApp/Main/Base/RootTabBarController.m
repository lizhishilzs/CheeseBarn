//
//  BaseTabBarController.m
//  CheeseProject
//
//  Created by Cheese on 2017/10/23.
//  Copyright © 2017年 CheeseProject. All rights reserved.
//

#import "RootTabBarController.h"

#import "BaseNavViewController.h"

//#import "RootTabBarController+CFMotion.h"
@interface RootTabBarController ()

@property (nonatomic, assign) NSInteger requestTime;

@end

@implementation RootTabBarController
#pragma mark - ♻️life cycle
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tabBar.backgroundImage = [UIImage imageWithColor:UIColorFromRGB(0xFFFFFF)];
    [self addChildViewControllers];
//#if DEBUG
//    // debug 模式下，开启摇一摇切环境的功能
//    [self startObserveMotion];
//#endif
}

#pragma mark - 🔒private
- (void)addChildViewControllers {
    
    [self setupChildViewControllerWithVcString:@"RootViewcontroller"
                                     imageName:@"tabbar_home"
                                 selectedImage:@"tabbar_home_selected"
                                         title:@"首页"
                                           tag:0];
    
    [self setupChildViewControllerWithVcString:@"OrderListVC"
                                     imageName:@"tabbar_order"
                                 selectedImage:@"tabbar_order_selected"
                                         title:@"订单"
                                           tag:1];
    
    [self setupChildViewControllerWithVcString:@"CartVC"
                                     imageName:@"tabbar_cart"
                                 selectedImage:@"tabbar_cart_selected"
                                         title:@"购物车"
                                           tag:2];
    
    [self setupChildViewControllerWithVcString:@"DKMeVC"
                                     imageName:@"tabbar_me"
                                 selectedImage:@"tabbar_me_selected"
                                         title:@"我的"
                                           tag:3];
    
}

- (void)setupChildViewControllerWithVcString:(NSString *)vcString
                                   imageName:(NSString *)imageName
                               selectedImage:(NSString *)selectedImage
                                       title:(NSString *)title
                                         tag:(NSInteger)tag{
    Class cls = NSClassFromString(vcString);
    UIViewController *vc = [[cls alloc] init];
    vc.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:imageName]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.tag = tag;
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xD01027)} forState:UIControlStateSelected];
//    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x878787)} forState:UIControlStateNormal];
    
    BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}




@end
