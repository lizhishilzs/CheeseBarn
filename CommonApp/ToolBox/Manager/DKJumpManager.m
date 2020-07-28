//
//  DKJumpManager.m
//  CheeseProject
//
//  Created by Cheese on 2017/11/14.
//  Copyright © 2017年 CheeseProject. All rights reserved.
//

#import "DKJumpManager.h"

#import "VCManager.h"

#import "BaseNavViewController.h"
#import "BaseWebViewController.h"
//#import "LoginVC.h"
//#import <UShareUI/UShareUI.h>


@implementation DKJumpManager
//+ (void)presentLogInVC{
//    UIViewController *topVC = [[VCManager shareVCManager] getTopViewController];
//    LoginVC *vc = [[LoginVC alloc] init];
//    [topVC.navigationController pushViewController:vc animated:YES];
//}


+ (void)presentWebVCWithTitle:(NSString *)title
                      loadUrl:(NSString *)loadUrl{
    UIViewController *topVC = [[VCManager shareVCManager] getTopViewController];
    if (topVC.navigationController) {
        [self pushToWebVCWithNavgationVC:topVC.navigationController
                                   title:title
                                 loadUrl:loadUrl];
    }else{
        [self presentWebVCWithPresentedVC:topVC
                                    title:title
                                  loadUrl:loadUrl];
    }
}

+ (void)presentWebVCWithPresentedVC:(UIViewController *)presentedVC
                              title:(NSString *)title
                            loadUrl:(NSString *)loadUrl{
    if (presentedVC) {
        BaseWebViewController *webVC = [[BaseWebViewController alloc]init];
        webVC.loadUrl = [NSURL URLWithString:loadUrl];
        webVC.title = title;
        [presentedVC presentViewController:[[BaseNavViewController alloc]initWithRootViewController:webVC]
                                  animated:YES
                                completion:nil];
    }
}

+ (void)pushToWebVCWithNavgationVC:(UINavigationController *)navgationVC
                             title:(NSString *)title
                           loadUrl:(NSString *)loadUrl{
    if (navgationVC) {
        BaseWebViewController *webVC = [[BaseWebViewController alloc]init];
        webVC.loadUrl = [NSURL URLWithString:loadUrl];
        webVC.title = title;
        [navgationVC pushViewController:webVC animated:YES];
        [webVC.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

//+ (void)showShareUIWithTitle:(NSString *)title desc:(NSString *)desc img:(id)img link:(NSString *)link block:(void (^)(void))success
//{
//    UIViewController *topVC = [[VCManager shareVCManager] getTopViewController];
//    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ)]];
//    
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        // 根据获取的platformType确定所选平台进行下一步操作
//        
//        UMSocialMessageObject * message = [UMSocialMessageObject messageObject];
//        UMShareWebpageObject * share = [UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:img];
//        share.webpageUrl = link;
//        message.shareObject = share;
//        
//        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:message currentViewController:topVC completion:^(id result, NSError *error) {
//            if (error) {
//                UMSocialLogInfo(@"************Share fail with error %@*********",error);
//                [MBProgressHUD showInfoMessage:@"分享失败"];
//            }else{
//                if ([result isKindOfClass:[UMSocialShareResponse class]]) {
//                    UMSocialShareResponse *resp = result;
//                    //分享结果消息
//                    UMSocialLogInfo(@"response message is %@",resp.message);
//                    //第三方原始返回的数据
//                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
//                    [MBProgressHUD showInfoMessage:@"操作完成"];
//                    
//                    success();
//                }else{
//                    UMSocialLogInfo(@"response data is %@",result);
//                }
//            }
//        }];
//    }];
//}




@end
