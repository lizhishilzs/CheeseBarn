//
//  BaseWebViewController.m
//  CheeseProject
//
//  Created by Cheese on 2017/10/23.
//  Copyright © 2017年 CheeseProject. All rights reserved.
//

#import "BaseWebViewController.h"

@interface NSURLRequest (IgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;

@end
//NSURLRequest+IgnoreSSL.m
@implementation NSURLRequest (IgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    DKLog(@"allowsAnyHTTPSCertificateForHost");
    return YES;
}

@end


@interface BaseWebViewController ()
<UIWebViewDelegate,
UIGestureRecognizerDelegate>

@end

@implementation BaseWebViewController
#pragma mark - ♻️life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // 如果是导航栏，设置默认leftBarItem
    if (self.navigationController) {
        //统一设置导航栏
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xFFFFFF);
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(clickAction_leftItem:)];
        leftBarButtonItem.tintColor = UIColorFromRGB(0x333333);
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
    
    [self.view addSubview:self.webview];
    if (IS_IPHONE_X) {
        [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
             make.bottom.equalTo(self.view).offset(-X_foot);
        }];
    } else {
        [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    
    
    if (self.loadUrl) {
        [self.webview loadRequest:[NSURLRequest requestWithURL:self.loadUrl
                                                   cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                               timeoutInterval:10]];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

#pragma mark - 🔄overwrite
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

#pragma mark - 🍐delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // 1. 框架使用第一步 拦截跳转
    return [self.webview dispatchURL:request.URL] == NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 2. 注册 定义JS和OC之间的通讯函数 => 绑定 JS 函数 和 OC 函数
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (title &&
        !self.title &&
        self.title.length == 0) {
        // self.title 没有，就用h5的title
        self.title = title;
    }
    [self.webview registerJSMethod:@"finish" target:self method:@selector(goBack:)];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSString *failUrlString = error.userInfo[NSURLErrorFailingURLStringErrorKey];
    if ([failUrlString isEqualToString:self.loadUrl.absoluteString]) {
        if (self.navigationController.navigationBar.hidden == YES) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController setNavigationBarHidden:NO animated:YES];
            });
        }
    }
}

#pragma mark -- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([self.webview canGoBack]) {
        [self.webview goBack];
        return NO;
    }
    
    return YES;
}
#pragma mark - 🎬event response
- (void)clickAction_leftItem:(UIButton *)button{
    if ([self.webview canGoBack]) {
        [self.webview goBack];
        return;
    }
    [self goBack];
}

#pragma mark - 🔒private
- (NSDictionary *)goBack:(NSDictionary *)params{
    [self goBack];
    
    return @{};
}

#pragma mark - 🚪public
- (void)goBack{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - ☸getter and setter
-(UIWebView *)webview{
    if (_webview == nil) {
        _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight)];
        _webview.delegate = self;
        _webview.scrollView.bounces = NO;
        _webview.backgroundColor = [UIColor whiteColor];
        _webview.scalesPageToFit = YES;
    }
    return _webview;
}

@end
