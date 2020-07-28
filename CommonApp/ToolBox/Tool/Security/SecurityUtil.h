//
//  SecurityUtil.h
//  Encryption
//
//  Created by niujinyong on 14-9-1.
//  Copyright (c) 2014年 AllanNiu. All rights reserved.
//


/**
 *  ios 苹果系统开放的加密接口  <CommonCrypto/CommonCryptor.h>  好像是3个
 */

#import <Foundation/Foundation.h>

@interface SecurityUtil : NSObject

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;
+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;

#pragma mark - AES加密
/**
 *  将字符串转换成带密码的data
 *
 *  @param string 要加密的字符串
 *
 *  @return 加密后的字符串
 */
+(NSData *)encryptAESData:(NSString *)string;
/**
 *  将带密码的data转换成字符串
 *
 *  @param data 要解密的data数据
 *
 *  @return 解密后的字符串
 */
+(NSString *)decryptAESData:(NSData *)data;

#pragma mark - MD5加密
/**
 *  对字符串进行MD5加密
 *
 *  @param string 要md5加密的字符串
 *
 *  @return 加密后的字符串
 */
+(NSString *)encryptMD5String:(NSString *)string;


#pragma mark - SHA1(哈希)加密
/**
 *  对字符串进行SHA1加密
 *
 *  @param string 需要加密的字符串
 *
 *  @return 加密后的字符串
 */
+(NSString *)encryptSHA1String:(NSString *)string;




@end
