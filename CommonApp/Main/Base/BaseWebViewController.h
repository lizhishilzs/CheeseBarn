//
//  BaseWebViewController.h
//  CheeseProject
//
//  Created by Cheese on 2017/10/23.
//  Copyright © 2017年 CheeseProject. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIWebView+Bridge.h"

/**
 BaseWebViewController *webVC = [[BaseWebViewController alloc] init];
 webVC.loadUrl = [NSURL URLWithString:fullPath];
 [self.navigationController pushViewController:webVC animated:YES];
 [webVC.navigationController setNavigationBarHidden:NO animated:YES]; // 导航栏不隐藏
 */

@interface BaseWebViewController : UIViewController

@property (nonatomic, strong) NSURL *loadUrl;
@property (nonatomic, strong) UIWebView *webview;

- (void)goBack;
/**
 webview加载完后，子类可以实现，注册与JS交互的方法
 默认注册了返回上一层vc方法
 
 @param webView webview
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

@end
