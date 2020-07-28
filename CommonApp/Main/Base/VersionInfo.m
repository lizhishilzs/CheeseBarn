//
//  VersionInfo.m
//  CheeseProject
//
//  Created by Cheese on 2018/8/27.
//  Copyright © 2018年 Dookay. All rights reserved.
//

#import "VersionInfo.h"

@implementation VersionInfo

#pragma mark - 单例 -versionShared
+ (instancetype)versionShared {
    static id instace;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[self alloc] init];
    });
    return instace;
}

@end
