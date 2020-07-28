//
//  RootViewcontroller.m
//  CommonApp
//
//  Created by cheese on 2020/7/27.
//  Copyright © 2020 cheese. All rights reserved.
//

#import "RootViewcontroller.h"

@interface RootViewcontroller ()

@end

@implementation RootViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *newview = [[UIView alloc]init];
    newview.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:newview];
    [newview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    
}



@end
