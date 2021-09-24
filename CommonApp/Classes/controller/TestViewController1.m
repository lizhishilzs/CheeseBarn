//
//  TestViewController1.m
//  CommonApp
//
//  Created by cheese on 2021/9/23.
//  Copyright © 2021 cheese. All rights reserved.
//

#import "TestViewController1.h"
#import "LoginModel.h"
#define _globaluser  [UserInfo customerShared]
@interface TestViewController1 ()
@property (nonatomic , strong) NSString * code;
@end

@implementation TestViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [self loadData];
}

-(void)loadData{

    [[Interface instance]request:DKInterfaceRequestTypeGet baseUrl:BASE_URL urlString:getuserInfo parameters:nil finished:^(id responseObject, NSString *error) {
        if (responseObject != nil) {
            NSDictionary *getdata = responseObject;
            NSLog(@"data:%@",getdata);
            [_globaluser yy_modelSetWithDictionary:getdata];
            NSLog(@"_globaluser:%@",_globaluser.yunxin_accid);
        }
        if (error != nil) {
            NSLog(@"error:%@",error);
        }
    }];
}

@end
