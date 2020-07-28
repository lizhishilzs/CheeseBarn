//
//  CustomerInfo.h
//  CheeseProject
//
//  Created by Cheese on 2017/10/25.
//  Copyright © 2017年 CheeseProject. All rights reserved.
//

#import <Foundation/Foundation.h>

//用户信息存储

/** 便捷访问宏*/
#define _CustomerInfo [CustomerInfo customerShared]

//个人相关
#define key_customerId              @"userId"
#define key_phoneNum                @"mobileNum"
#define key_token                   @"token"
#define key_authStatus              @"authStatus"
#define key_nickname                @"nickname"
#define key_userAvatar              @"avatar"
#define key_regTime                 @"regTime"
#define key_loginType               @"loginType"

    //token date key
#define kTokenDate    @"token_date_fxbtg"
#define UD_TokenDate   [MyTool readValueForKey:kTokenDate]
    //token过期时间
#define LIT_ONE_MINUTE          (60)
#define LIT_ONE_HOUR            (60 * LIT_ONE_MINUTE)
#define kTokenTimeOut           (6 * LIT_ONE_HOUR)


@interface CustomerInfo : NSObject

@property (nonatomic, copy) NSString *customerId;

/** */
@property(nonatomic, copy) NSString *authStatus;

/** */
@property(nonatomic, copy) NSString *avatar;

/** */
@property(nonatomic, copy) NSString *mobileNum;

/** */
@property(nonatomic, copy) NSString *nickName;

/** */
@property(nonatomic, copy) NSString *regTime;

/** */
@property(nonatomic, copy) NSString *token;

@property (nonatomic, assign) BOOL isLogIn;

@property (nonatomic, assign) NSInteger auditStatus;

#pragma mark - 方法 -
/** 单例方法*/
+ (instancetype)customerShared;

- (void)logOut;



@end
