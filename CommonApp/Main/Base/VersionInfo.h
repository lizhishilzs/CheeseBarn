//
//  VersionInfo.h
//  CheeseProject
//
//  Created by Cheese on 2018/8/27.
//  Copyright © 2018年 Dookay. All rights reserved.
//

#import <Foundation/Foundation.h>

#define _VersionInfo [VersionInfo versionShared]

#define RULE_Email @"email"
#define RULE_Phone @"phone"


@interface VersionInfo : NSObject
/*
 审核状态
 */
@property (nonatomic, assign) BOOL auditStatus;
/*
 更新链接
 */
@property (nonatomic, copy) NSString *packageLink;
/*
 强制更新状态
 */
@property (nonatomic, assign) int updateType;


+ (instancetype)versionShared;

@end
