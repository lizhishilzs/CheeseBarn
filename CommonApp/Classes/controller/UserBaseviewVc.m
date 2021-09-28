//
//  UserBaseviewVc.m
//  CommonApp
//
//  Created by cheese on 2021/9/24.
//  Copyright © 2021 cheese. All rights reserved.
//

#import "UserBaseviewVc.h"
#import "NextViewController.h"
@interface UserBaseviewVc ()

@end

@implementation UserBaseviewVc
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试一下";
    self.view.backgroundColor = [UIColor redColor];
    UIView *newview = [[UIView alloc]init];
    newview.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:newview];
    [newview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(DKGloablConfig.Topheight);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-DKGloablConfig.Bottomheight);
    }];
    UIButton *gotonext = [[UIButton alloc]init];
    [gotonext setTitle:@"下一页" forState:UIControlStateNormal];
    gotonext.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    [gotonext setTitleColor:kBlackColor forState:UIControlStateNormal];
    [gotonext addTarget:self action:@selector(gotoNextPage) forControlEvents:UIControlEventTouchUpInside];
    [newview addSubview:gotonext];
    [gotonext mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(newview);
    }];
}
-(void)gotoNextPage{
    NextViewController *vc = [[NextViewController alloc]init];
    [self.navigationController pushViewController:vc animated:true];
}


@end
