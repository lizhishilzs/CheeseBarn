//
//  DESEncryption.m
//  CheeseProject
//
//  Created by Cheese on 2017/4/3.
//  Copyright © 2017年 稻壳. All rights reserved.
//

#import "DESEncryption.h"
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"


@interface DESEncryption ()

@end

const Byte iv[] = {1,2,3,4,5,6,7,8};

@implementation DESEncryption

+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key{
    return [self encryptUseDES:plainText key:key bufferSize:1024];
}

+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key bufferSize:(NSUInteger)bufferSize
{
    NSString *ciphertext = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[bufferSize];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          [textData bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    }else if (cryptStatus == kCCBufferTooSmall){
        return [self encryptUseDES:plainText key:key bufferSize:numBytesEncrypted];
    }else{
        return @"加密失败";
    }
    
    return ciphertext;
}

//解密

+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key
{
    NSString *plaintext = nil;
    NSData *cipherdata = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          [cipherdata bytes], [cipherdata length],
                                          buffer, 1024,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}

@end
