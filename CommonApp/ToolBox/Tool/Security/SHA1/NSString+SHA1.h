//
//  NSString+SHA1.h
//  InternetOfThings
//
//  Created by 于洪东 on 16/8/16.
//  Copyright © 2016年 于洪东. All rights reserved.
//


// http://www.jianshu.com/p/7500ee76e8ae  这篇文章很好


#import <Foundation/Foundation.h>

@interface NSString (SHA1)

/**
 *  哈希算法加密数据
 *
 *  @return 加密后的数据
 */
- (NSString *)SHA1Encryption;


@end
