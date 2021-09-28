//
//  DKGloablConfig.m
//  CheeseProject
//
//  Created by Cheese on 2017/10/23.
//  Copyright © 2017年 CheeseProject. All rights reserved.
//

#import "DKGloablConfig.h"

NSString * DKDeviceToken = @"device_Token"; // userAgent 用

/**** 内部跳转协议配置 ****/
NSString *DKURLSCHEME = @"DK"; // 协议头
NSString *DKURLJumpHost = @"jump"; // jump动作
NSString *DKURLOpenWeb = @"/openWeb"; // 跳H5


@implementation DKGloablConfig
+ (CGFloat)Bottomheight
{
    if (@available(iOS 11.0, *)) {
        return UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom;
    }else{
        return  0;
    }
}
+ (CGFloat)Topheight
{
    if (@available(iOS 11.0, *)) {
        return UIApplication.sharedApplication.delegate.window.safeAreaInsets.top;
    }else{
        return  0;
    }
}
@end

