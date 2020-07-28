//
//  CustomerInfo.m
//  CheeseProject
//
//  Created by Cheese on 2017/10/25.
//  Copyright © 2017年 CheeseProject. All rights reserved.
//

#import "CustomerInfo.h"
#import "GTMBase64.h"
#import "NSString+LTEncryption.h"

@implementation CustomerInfo

#pragma mark - 单例 -
+ (instancetype)customerShared {
    static id instace;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[self alloc] init];
    });
    return instace;
}

#pragma mark - description -
- (NSString *)description {
    return [self yy_modelDescription];
}

#pragma mark - 🚪public
- (void)logOut{
    // 删除userID，即登出
    [self removeValueforKey:key_customerId];
    [self removeValueforKey:key_nickname];
    [self removeValueforKey:key_userAvatar];
    // 删除token
    [self removeValueforKey:key_token];
}

- (void)setUserId:(NSString *)userId
{
    if (userId == nil || userId.length == 0) {
        return;
    }
    [self writeValue:userId forKey:key_customerId];
}

- (NSString *)userId
{
    return [self readValueForKey:key_customerId];
}

- (void)setToken:(NSString *)token
{
    if (token == nil || token.length == 0) {
        [self removeValueforKey:key_token];
        return;
    }
    [self writeValue:token forKey:key_token];
    [MyTool writeValue:[NSDate date] forKey:kTokenDate];
}

- (NSString *)token
{
    return [self readValueForKey:key_token];
}

- (void)setNickName:(NSString *)nickName
{
    if (nickName == nil || nickName.length == 0) {
        return;
    }
    [self writeValue:nickName forKey:key_nickname];
}

- (NSString *)nickName
{
    return [self readValueForKey:key_nickname];
}

- (void)setMobileNum:(NSString *)mobileNum
{
    if (mobileNum == nil || mobileNum.length == 0) {
        return;
    }
    [self writeValue:mobileNum forKey:key_phoneNum];
}

- (NSString *)mobileNum
{
    return [self readValueForKey:key_phoneNum];
}

- (void)setAvatar:(NSString *)avatar
{
    if (avatar == nil || avatar.length == 0) {
        return;
    }
    [self writeValue:avatar forKey:key_userAvatar];
}

- (NSString *)avatar
{
    NSString *avatar = [self readValueForKey:key_userAvatar];
    if (avatar == nil) {
        return @"";
    }
    
    return avatar;
}

- (BOOL)isLogIn{
    NSString *token = [self readValueForKey:key_token];
    if (token && token.length > 0) {
        
        return YES;
    }
    return NO;
}

- (void)setIsNOTFirstLogin:(BOOL)isNOTFirstLogin
{
    if (isNOTFirstLogin == NO) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:key_loginType];
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key_loginType];
    }
}

- (BOOL)isNOTFirstLogin
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key_loginType];
}

#pragma mark - 读写删除 -
- (void)removeValueforKey:(NSString *)key{
    if ([self readValueForKey:key]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}

- (void)writeValue:(id)value forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults]  setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:key];
}

- (id)readValueForKey:(NSString *)key{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (!obj) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithData:obj];
}

@end
