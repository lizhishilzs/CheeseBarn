//
//  DESEncryption.h
//  CheeseProject
//
//  Created by Cheese on 2017/4/3.
//  Copyright © 2017年 稻壳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DESEncryption : NSObject

//DES加密
+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
//DES解密
+ (NSString *) decryptUseDES:(NSString *)cipherText key:(NSString*)key;


@end
