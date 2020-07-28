//
//  UtilTool.h
//  MovieDate
//
//  Created by 蔡成汉 on 15/11/3.
//  Copyright © 2015年 上海佳黛品牌策划有限公司. All rights reserved.
//

//对字符串URL编解码
#import <Foundation/Foundation.h>

@interface UtilTool : NSObject

+ (NSString*)decodeURL:(NSString *)string;
+ (NSString*)encodeURL:(NSString *)string;
@end
