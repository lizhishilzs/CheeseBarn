//
//  BaseViewController.m
//  CheeseProject
//
//  Created by Cheese on 2017/10/23.
//  Copyright © 2017年 CheeseProject. All rights reserved.
//

#import "BaseViewController.h"
#import <objc/runtime.h>
// view
#import "AppDelegate.h"

#import "VCManager.h"


static char *btnClickAction;

@interface BaseViewController ()

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@property (nonatomic, assign) BOOL statusBarHidden;



@end

@implementation BaseViewController
#pragma mark - ♻️life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    // 初始化导航栏
    [self p_setNavBar];
//    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
//    [IQKeyboardManager sharedManager].enable = YES;
//    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder = NO;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window endEditing:YES];
}

- (void)dealloc{
    DKLog(@"dealloc %@",self.class);
}

#pragma mark - 🔄overwrite
//是否隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return self.statusBarHidden;
}

//状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.statusBarStyle) {
        return self.statusBarStyle;
    } else {
        return UIStatusBarStyleDefault;
    }
}

#pragma mark - public method
-(void)setNavigationBarColor:(UIColor *)color{
    self.navigationController.navigationBar.barTintColor = color;
}

-(void)setNavigationBarImage:(UIImage *)image{
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    // 隐藏导航栏上的线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
}

-(void)setNavigationBarTitleAttributes:(NSDictionary *)attributes{
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
}

-(void)setLeftButtonWithTitle:(NSString *)title
                        Image:(NSString *)image
                SelectedImage:(NSString *)selectedImage
                       Action:(void (^)(void))btnClickBlock{
    self.navLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.navLeftBtn setBackgroundColor:[UIColor clearColor]];
    objc_setAssociatedObject(self.navLeftBtn, &btnClickAction, btnClickBlock, OBJC_ASSOCIATION_COPY);
    [self setCustomButton:self.navLeftBtn Title:title Image:image SelectedImage:selectedImage];
    [self.navLeftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];
}

-(void)setRightButtonWithTitle:(NSString *)title
                         Image:(NSString *)image
                 SelectedImage:(NSString *)selectedImage
                        Action:(void (^)(void))btnClickBlock{
    self.navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    objc_setAssociatedObject(self.navRightBtn, &btnClickAction, btnClickBlock, OBJC_ASSOCIATION_COPY);
    [self setCustomButton:self.navRightBtn Title:title Image:image SelectedImage:selectedImage];
    [self.navRightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn];
}

#pragma mark - private method
-(void)p_setNavBar{
    [self setNavigationBarColor:[UIColor whiteColor]];
    [self setNavigationBarTitleAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x323232),
                                            NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    //统一设置导航栏
    
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;//不透明设置解决界面下移问题
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xFFFFFF);
    
    //统一设置返回按钮
    //    if (self.navigationController.childViewControllers.count > 1) {
    __weak typeof(self) weakSelf = self;
    [self setLeftButtonWithTitle:nil Image:@"xn_default_back" SelectedImage:@"" Action:^{
        [weakSelf clickAction_leftItemClick];
    }];
    //    }
    
    /////////////
    //再定义一个imageview来等同于这个黑线
    UIImageView *navBarHairlineImageView;
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden = YES;
    
    self.separateLine.frame = CGRectMake(0,
                                         44,
                                         mainWidth,
                                         0.5);
//    [self.navigationController.navigationBar addSubview:self.separateLine];
}

// 通过一个方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

-(void)setCustomButton:(UIButton *)button
                 Title:(NSString *)title
                 Image:(NSString *)image
         SelectedImage:(NSString *)selectedImage{
    if (image) {
        [button setImage:[[UIImage imageNamed:image]
                          imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                forState:UIControlStateNormal];
    }
    if (selectedImage) {
        [button setImage:[[UIImage imageNamed:selectedImage]
                          imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                forState:UIControlStateHighlighted];
    }
    
    if (title) {
        button.titleLabel.font = [MyTool regularFontWithSize:15];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    }
    [button sizeToFit];
    [button addTarget:self action:@selector(actionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 🎬event response
- (void)clickAction_leftItemClick{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)actionBtnClick:(UIButton *)btn {
    void (^btnClickBlock) (void) = objc_getAssociatedObject(btn, &btnClickAction);
    btnClickBlock();
}

#pragma mark - touchesBegan -
//统一处理键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window endEditing:YES];
}

#pragma mark - 统一处理状态栏 -
- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
             statusBarHidden:(BOOL)statusBarHidden
     changeStatusBarAnimated:(BOOL)animated {
    
    self.statusBarStyle = statusBarStyle;
    self.statusBarHidden = statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
    else{
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

#pragma mark - ☸getter and setter
- (UIView *)separateLine{
    if (!_separateLine) {
        _separateLine = [[UILabel alloc] init];
        _separateLine.backgroundColor = UIColorFromRGB(0xD8D7D7);
    }
    
    return _separateLine;
}

- (CGFloat)bottomOffset{
    if (IS_IPHONE_X) {
        return -1 * X_foot;
    }
    return 0;
}
//
//-(BOOL)checkAllText{
//    for (DKTextField *tf in _textArr) {
//        if ([tf checkText] == NO) {
//            return NO;
//        }
//    }
//    return YES;
//}

-(NSMutableArray *)textArr{
    if (_textArr == nil) {
        _textArr = [[NSMutableArray alloc] init];
    }
    return _textArr;
}
@end

