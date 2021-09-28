//
//  NextViewController.m
//  CommonApp
//
//  Created by cheese on 2021/9/24.
//  Copyright © 2021 cheese. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()
@property (nonatomic , strong) UIButton * navLeftBtn;
@end

@implementation NextViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    UIView *newview = [[UIView alloc]init];
    newview.backgroundColor = [UIColor blueColor];
    [self.view addSubview:newview];
    [newview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(DKGloablConfig.Topheight);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(50*ScaleX);
    }];
    
    self.navLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.navLeftBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [self.navLeftBtn addTarget:self action:@selector(backview) forControlEvents:UIControlEventTouchUpInside];
    [newview addSubview:self.navLeftBtn];
    [self.navLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(newview.mas_top).offset(10);
            make.left.equalTo(self.view.mas_left).offset(10);
    }];
}

-(void)backview{
    [self.navigationController popViewControllerAnimated:true];
}

@end
