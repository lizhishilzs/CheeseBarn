//
//  DKHandleUrlManager.m
//  CheeseProject
//
//  Created by Cheese on 2017/11/14.
//  Copyright © 2017年 CheeseProject. All rights reserved.
//

#import "DKHandleUrlManager.h"

#import "MDUrl.h"
#import "DKJumpManager.h"

@implementation DKHandleUrlManager

#pragma mark - 🔒private
+ (void)jumpToWebVCWithUrl:(NSURL *)url{
    NSString *webUrl = [url getValueInQueryForKey:@"webUrl"
                                  isCaseSensitive:NO];
    NSString *webTitle = [url getValueInQueryForKey:@"webTitle"
                                    isCaseSensitive:NO];
    [DKJumpManager presentWebVCWithTitle:webTitle loadUrl:webUrl];
}
#pragma mark - 🚪public
+(BOOL)handleOpenURL:(NSURL*)url{
    if ([url.scheme isEqualToString:DKURLSCHEME]) {
        NSString *host = url.host;
        // 内部跳转处理
        if ([host isEqualToString:DKURLJumpHost]) {
            NSString *path = url.path;
            if ([path isEqualToString:DKURLOpenWeb]) {
                [self jumpToWebVCWithUrl:url];
                return YES;
            }
        }
    }
    return NO;
}

@end
