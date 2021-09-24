//
//  RootViewcontroller.m
//  CommonApp
//
//  Created by cheese on 2020/7/27.
//  Copyright © 2020 cheese. All rights reserved.
//

#import "RootViewcontroller.h"
#import "UIButton+ImageTitleSpacing.h"
#import "LoginModel.h"
@interface RootViewcontroller ()
@property (nonatomic , strong) UIButton *testbtn;
@end

@implementation RootViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *newview = [[UIView alloc]init];
    newview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:newview];
    [newview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    self.testbtn = [[UIButton alloc]init];
    
    _testbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_testbtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    [newview addSubview:_testbtn];
    [_testbtn setImage:[UIImage imageNamed:@"testduck"] forState:UIControlStateNormal];
    [_testbtn layoutButtonWithEdgeInsetsStyle:1 imageTitleSpace:10];
    [_testbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(newview);
    }];
//    NSDictionary *getidc = @{@"myid":@"test1"};
//    NSArray * array = @[1, 2];
//    [self loadData];
    
}

-(void)loadData{
    NSMutableDictionary *sendDic = [NSMutableDictionary dictionary];
    [sendDic setValue:@(3) forKey:@"user_from"];
    [sendDic setValue:@"13801886270" forKey:@"phone"];
    [sendDic setValue:@"1212" forKey:@"code"];
    [[Interface instance]request:DKInterfaceRequestTypePost baseUrl:BASE_URL urlString:loginURL parameters:sendDic finished:^(id responseObject, NSString *error) {
        if (responseObject != nil) {
            NSDictionary *getdata = responseObject;
            NSLog(@"data:%@",getdata);
            [_LoginInfo yy_modelSetWithDictionary:getdata];
            NSLog(@"_LoginInfo:%@",_LoginInfo.token);
            [_testbtn setTitle:_LoginInfo.name forState:UIControlStateNormal];
            
        }
        if (error != nil) {
            NSLog(@"error:%@",error);
        }
    }];
}



@end
