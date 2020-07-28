//
//  NetworkRequestURL.m
//  CheeseProject
//
//  Created by Cheese on 2017/7/11.
//  Copyright © 2017年 稻壳. All rights reserved.
//

#import "DKNetworkRequestURL.h"


//************************** 登录注册 **********************//
/*
 注册
 */
NSString *registerURL = @"/loginconnect/mobile/register";
/*
 获取短信验证码
 */
NSString *sendCode = @"/passport/sendCode";
/*
 校验短信验证码
 */
NSString *checkCode = @"/loginconnect/smscode/check";
/*
 修改绑定手机
 */
NSString *changeCode = @"/member/security/edit/mobile";
/*
 手机登录
 */
NSString *loginPhoneURL = @"/passport/verifyCode";
/*
 账号密码登录
 */
NSString *loginURL = @"/login";
/*
 手机找回密码
 */
NSString *findpwd = @"/loginconnect/mobile/findpwd";
/*
 手机修改密码
 */
NSString *changepwd = @"/member/security/edit/newPwd";
/*
 获取验证码
 */
NSString *encryptionCode = @"/common/encryption/sendCode";
/*
 获取验证码加密参数
 */
NSString *validationCode = @"/common/graphics/validation";
/*
 微信授权登录
 */
NSString *wxpassport = @"/passport/wxAuth";


//************************** 首页 **********************//
/*
 首页
 */

//************************** 用户个人信息 **********************//
/*
 获取用户信息
 */
NSString *getuserInfo = @"/u/profile";




