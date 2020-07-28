//
//  DKJumpManager.h
//  CheeseProject
//
//  Created by Cheese on 2017/11/14.
//  Copyright © 2017年 CheeseProject. All rights reserved.
//

#import <Foundation/Foundation.h>

//跳转路由
@interface DKJumpManager : NSObject


/**
 present 登入vc
 */
+ (void)presentLogInVC;

/**
 present web vc

 @param presentedVC presentedVC
 @param title title
 @param loadUrl web加载url
 */
+ (void)presentWebVCWithPresentedVC:(UIViewController *)presentedVC
                              title:(NSString *)title
                            loadUrl:(NSString *)loadUrl;

/**
 rootVC present web vc

 @param title title
 @param loadUrl web加载url
 */
+ (void)presentWebVCWithTitle:(NSString *)title
                      loadUrl:(NSString *)loadUrl;

/**
 push to web vc

 @param navgationVC 导航栏
 @param title title
 @param loadUrl web加载url字符串
 */
+ (void)pushToWebVCWithNavgationVC:(UINavigationController *)navgationVC
                             title:(NSString *)title
                           loadUrl:(NSString *)loadUrl;

+ (void)showShareUIWithTitle:(NSString *)title
                        desc:(NSString *)desc
                         img:(id)img
                        link:(NSString *)link
                       block:(void(^)(void))success;
@end
