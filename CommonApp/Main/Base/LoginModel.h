//
//  LoginModel.h
//  CommonApp
//
//  Created by cheese on 2021/9/24.
//  Copyright © 2021 cheese. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define _LoginInfo [LoginModel customerShared]
@interface LoginModel : NSObject
@property (nonatomic , assign) NSInteger tid;
@property (nonatomic , strong) NSString * name;
@property (nonatomic , strong) NSString * username;
@property (nonatomic , strong) NSString * phone;
@property (nonatomic , strong) NSString * avatar;
@property (nonatomic , assign) NSInteger weixin_id;
@property (nonatomic , assign) bool password;
@property (nonatomic , copy) NSString * token;
#pragma mark - 方法 -
/** 单例方法*/
+ (instancetype)customerShared;
@end

@interface UserInfo : NSObject
@property (nonatomic , strong) NSString * username;
@property (nonatomic , strong) NSString * yunxin_accid;
#pragma mark - 方法 -
/** 单例方法*/
+ (instancetype)customerShared;
@end

NS_ASSUME_NONNULL_END
