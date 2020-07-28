//
//  DKHandleUrlManager.h
//  CheeseProject
//
//  Created by Cheese on 2017/11/14.
//  Copyright © 2017年 CheeseProject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKHandleUrlManager : NSObject

/**
 处理外部URL

 @param url 外部URL
 @return 是否处理
 */
+(BOOL)handleOpenURL:(NSURL*)url;

@end
