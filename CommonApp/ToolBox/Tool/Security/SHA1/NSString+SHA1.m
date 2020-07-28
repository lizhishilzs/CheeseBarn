//
//  NSString+SHA1.m
//  InternetOfThings
//
//  Created by 于洪东 on 16/8/16.
//  Copyright © 2016年 于洪东. All rights reserved.
//

#import "NSString+SHA1.h"
#import<CommonCrypto/CommonDigest.h>

@implementation NSString (SHA1)


-(NSString *)SHA1Encryption{
//    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
    
}







@end
