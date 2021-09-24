//
//  LoginModel.m
//  CommonApp
//
//  Created by cheese on 2021/9/24.
//  Copyright © 2021 cheese. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
- (void)setToken:(NSString *)token
{
    if (token == nil || token.length == 0) {
        [MyTool removeValueforKey:@"token"];
        return;
    }
    [MyTool writeValue:token forKey:@"token"];
}
- (NSString *)token{
    return [MyTool readValueForKey:key_token];
}
+ (instancetype)customerShared {
    static id instace;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[self alloc] init];
    });
    return instace;
}


@end
@implementation UserInfo
+ (instancetype)customerShared {
    static id instace;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[self alloc] init];
    });
    return instace;
}

@end




