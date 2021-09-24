                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        //
//  Interface.m
//  goldmetal
//
//  Created by Cheese on 2017/1/19.
//  Copyright © 2017年 稻壳. All rights reserved.
//

#import "Interface.h"
#import "VCManager.h"


//#import "GTMBase64.h"
//#import "UserAgent.h"

@interface Interface ()


//MBProgressHUD 动画数组
@property(nonatomic,strong) NSMutableArray *progressImg;

@property(nonatomic,weak) MBProgressHUD *hud;

@property(nonatomic,weak) UIImageView *imgView;


@end


@implementation Interface

+ (Interface *)instance{
    static Interface *_interface = nil;
    static dispatch_once_t onceInterfaceInitialize;
    dispatch_once(&onceInterfaceInitialize, ^{
        _interface = [[Interface alloc]init];
        _interface.baseUrl = BASE_URL;
        _interface.baseWebUrl = BASE_WEB_URL;
    });
    return _interface;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _shareManger = [AFHTTPSessionManager manager];
        _shareManger.responseSerializer = [AFJSONResponseSerializer serializer];
        
        //add by mo
//        _shareManger.securityPolicy = [self getCustomHttpsPolicy];
//        _shareManger.securityPolicy.allowInvalidCertificates = YES;
        
        //此处统一设置body,响应的数据格式
//        [_shareManger.requestSerializer setValue:[[UserAgent ShardInstnce] getUserAgent]
//                              forHTTPHeaderField:@"User-Agent"];
        
    }
    return self;
}

/**
 网络请求
 
 @param method 请求方式 get、post
 @param baseUrl baseUrl
 @param urlStirng 接口
 @param parameters 参数
 @param type 请求平台
 @param isEncrypted 参数是否加密
 @param finished 请求完成回调
 */
- (void)request:(DKInterfaceRequestType)method
        baseUrl:(NSString *)baseUrl
      urlString:(NSString *)urlStirng
     parameters:(id)parameters
   platformType:(PlatformType)type
    isEncrypted:(BOOL)isEncrypted
       finished:(void (^)(id responseObject, NSString *error))finished {
    if (baseUrl == nil || baseUrl.length == 0) {
        return;
    }
    // 如果baseUrl是BASE_URL宏定义的，则替换
    if ([baseUrl isEqualToString:BASE_URL]) {
        baseUrl = self.baseUrl;
    }
    // 如果baseUrl是BASE_WEB_URL宏定义的，则替换
    if ([baseUrl isEqualToString:BASE_WEB_URL]) {
        baseUrl = self.baseWebUrl;
    }
    
    urlStirng = [baseUrl stringByAppendingString:urlStirng];
    
    DKLog(@"请求链接url = %@    请求参数===============%@",urlStirng,parameters);
    NSDictionary *finaldic = [self handelParameters:parameters isEncrypted:isEncrypted];
    switch (type) {
        case PlatformTypeNone:
            [self customer_request:method urlString:urlStirng parameters:finaldic finished:finished];
            break;
    }
}

- (void)request:(DKInterfaceRequestType)method
        baseUrl:(NSString *)baseUrl
      urlString:(NSString *)urlStirng
     parameters:(id)parameters
   platformType:(PlatformType)type
    isEncrypted:(BOOL)isEncrypted
finishedWithMsg:(void (^)(id responseObject, NSString *error))finished {
    if (baseUrl == nil || baseUrl.length == 0) {
        return;
    }
    // 如果baseUrl是BASE_URL宏定义的，则替换
    if ([baseUrl isEqualToString:BASE_URL]) {
        baseUrl = self.baseUrl;
    }
    // 如果baseUrl是BASE_WEB_URL宏定义的，则替换
    if ([baseUrl isEqualToString:BASE_WEB_URL]) {
        baseUrl = self.baseWebUrl;
    }
    
    urlStirng = [baseUrl stringByAppendingString:urlStirng];
    
    DKLog(@"请求链接url = %@    请求参数===============%@",urlStirng,parameters);
    NSDictionary *finaldic = [self handelParameters:parameters isEncrypted:isEncrypted];
    switch (type) {
        case PlatformTypeNone:
            [self customer_request:method urlString:urlStirng parameters:finaldic finishedWithMsg:finished];
            break;
    }
}

- (void)request:(DKInterfaceRequestType)method
        baseUrl:(NSString *)baseUrl
      urlString:(NSString *)urlStirng
     parameters:(id)parameters
       finished:(void (^)(id, NSString *))finished {
    if (baseUrl == nil || baseUrl.length == 0) {
        return;
    }
    NSMutableDictionary *tempDic = [parameters mutableCopy];
    _shareManger.requestSerializer = [AFJSONRequestSerializer serializer];
    
    if (_LoginInfo.token.length) {
        [_shareManger.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",_LoginInfo.token] forHTTPHeaderField:@"Authorization"];
    }
   
    NSLog(@"######token =====%@   #######",_LoginInfo.token);
    [self request:method
          baseUrl:baseUrl
        urlString:urlStirng
       parameters:tempDic
     platformType:PlatformTypeNone
      isEncrypted:NO
         finished:finished];
}

- (void)requestform:(DKInterfaceRequestType)method
        baseUrl:(NSString *)baseUrl
      urlString:(NSString *)urlStirng
     parameters:(id)parameters
       finished:(void (^)(id, NSString *))finished {
    if (baseUrl == nil || baseUrl.length == 0) {
        return;
    }
    NSMutableDictionary *tempDic = [parameters mutableCopy];
    _shareManger.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    if (_LoginInfo.token.length) {
        [_shareManger.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",_LoginInfo.token] forHTTPHeaderField:@"Authorization"];
    }
    
    NSLog(@"######token =====%@   #######",_LoginInfo.token);
    [self request:method
          baseUrl:baseUrl
        urlString:urlStirng
       parameters:tempDic
     platformType:PlatformTypeNone
      isEncrypted:NO
         finished:finished];
}

- (void) request:(DKInterfaceRequestType)method
         baseUrl:(NSString *)baseUrl
       urlString:(NSString *)urlStirng
      parameters:(id)parameters
 finishedWithMsg:(void (^)(id responseObject, NSString *error))finished
{
    if (baseUrl == nil || baseUrl.length == 0) {
        return;
    }
    [self request:method
          baseUrl:baseUrl
        urlString:urlStirng
       parameters:parameters
     platformType:PlatformTypeNone
      isEncrypted:NO
  finishedWithMsg:finished];
}

#pragma mark - 自己平台 -
- (void)customer_request:(DKInterfaceRequestType)method
               urlString:(NSString *)urlStirng
              parameters:(id)parameters
                finished:(void (^)(id responseObject, NSString *error))finished {
    void(^successCallback)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DKLog(@"%@", parameters);
        DKLog(@"%@", urlStirng);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"%@",[responseObject objectForKey:@"code"]);
            NSNumber *getnum = [responseObject objectForKey:@"code"];
            if ([getnum integerValue] == 2000 || [getnum integerValue] == 0) {
                if (responseObject &&
                    ![responseObject isKindOfClass:[NSNull class]]) {
                    finished([responseObject objectForKey:@"data"],nil);
                }else {
                    if ([responseObject isKindOfClass:[NSNull class]]) {
                        finished(nil,nil);
                    }else{
                        finished(nil,@"数据格式返回错误");
                    }
                }
                
            }else {
                finished(nil,responseObject[@"message"]);
            }
        }else {
            DKLog(@"返回数据格式错误");
            finished(nil,@"返回数据格式错误");
        }
    };
    
    void(^failureCallBack)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //错误的统一输出
        DKLog(@"%@",error);
        if (error.code == -1001) {
//            [[GMBadNetworkView shareInstances] show];
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        if (httpResponse.statusCode == 401) {
            NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
            NSDictionary * dict = [defs dictionaryRepresentation];
            for (id key in dict) {
                [defs removeObjectForKey:key];
            }
            [defs synchronize];
            return;
        }
        
        finished(nil,@"网络错误");
    };
    
    if (method == DKInterfaceRequestTypeGet) {
        [self.shareManger GET:urlStirng parameters:parameters headers:nil progress:nil success:successCallback failure:failureCallBack];
        
    }else if(method == DKInterfaceRequestTypePost){
//        if ([urlStirng containsString:addUrl]) {
//            self.shareManger.requestSerializer = [AFHTTPRequestSerializer serializer];
//            [self.shareManger.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",_LoginInfo.token] forHTTPHeaderField:@"Authorization"];
//        }
        [self.shareManger POST:urlStirng parameters:parameters headers:nil progress:nil success:successCallback failure:failureCallBack];
    }else{
        [self.shareManger DELETE:urlStirng parameters:parameters headers:nil success:successCallback failure:failureCallBack];
    }

    
}


- (void)customer_request:(DKInterfaceRequestType)method
               urlString:(NSString *)urlStirng
              parameters:(id)parameters
         finishedWithMsg:(void (^)(id responseObject, NSString *error))finished
{
    void(^successCallback)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DKLog(@"请求的链接=====%@     请求的参数========%@",urlStirng, parameters);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            DKLog(@"请求的链接=====%@     请求的参数========%@     ============######返回的报文#######===========%@",urlStirng, parameters,responseObject);
            finished(responseObject,nil);
        }else {
            DKLog(@"返回数据格式错误");
            finished(nil,@"返回数据格式错误");
        }
    };
    
    void(^failureCallBack)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //错误的统一输出
        DKLog(@"%@",error);
        if (error.code == -1001) {
            
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        if (httpResponse.statusCode == 401) {
            NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
            NSDictionary * dict = [defs dictionaryRepresentation];
            for (id key in dict) {
                [defs removeObjectForKey:key];
            }
            [defs synchronize];
            return;
        }
        
        finished(nil,@"网络错误");
    };
    
    if (method == DKInterfaceRequestTypeGet) {
        [self.shareManger GET:urlStirng parameters:parameters headers:nil progress:nil success:successCallback failure:failureCallBack];
    }else if (method == DKInterfaceRequestTypePost){
        [self.shareManger POST:urlStirng parameters:parameters headers:nil progress:nil success:successCallback failure:failureCallBack];
    } else
        [self.shareManger DELETE:urlStirng parameters:parameters headers:nil success:successCallback failure:failureCallBack];
    
}

/**
 上传请求
 
 @param urlString 请求的网址字符串
 @param parameters 请求的参数
 @param block  上传数据
 @param uploadProgress 上传进度
 @param callBackBlock 回调
 */
- (void)uploadWithURLString:(NSString *)urlString
                 parameters:(id)parameters
  constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                   progress:(void (^)(NSProgress *))uploadProgress
              callBackBlock:(requestBlock)callBackBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.securityPolicy = [self getCustomHttpsPolicy];
    manager.requestSerializer.timeoutInterval = 20;
    NSString *requestUrlStr = [self appendUrlString:urlString];
    // upload
    [manager POST:requestUrlStr parameters:parameters headers:nil constructingBodyWithBlock:block progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = nil;
        if ([responseObject isKindOfClass:[NSData class]])
        {
            dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        }
        else if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            dic = responseObject;
        }
        if (callBackBlock) {
            callBackBlock(YES, dic, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (callBackBlock) {
            callBackBlock(NO, nil, @"上传失败");
        }
    }];
}

#pragma mark -- 请求处理
- (NSString *)appendUrlString:(NSString *)urlString
{
    NSString *requestUrlStr = [NSString stringWithFormat:@"%@%@",self.baseUrl,urlString];
    return requestUrlStr;
}

- (NSDictionary *)handelParameters:(id)parameters isEncrypted:(BOOL)isEncrypted{
    if (isEncrypted == YES) {
        // 参数加密处理，暂不用
        
    }else{
        // do nothing
    }
    
    return parameters;
}

// 证书
- (AFSecurityPolicy*)getCustomHttpsPolicy{
    
    //https 公钥证书配置
    
    NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"CheeseProject" ofType:@"cer"];
    
    NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
    
    NSSet *certSet = [NSSet setWithObject:certData];
    
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
    
    policy.allowInvalidCertificates = YES;// 是否允许自建证书或无效证书（重要！！！）
    
    policy.validatesDomainName = YES;//是否校验证书上域名与请求域名一致
    
    return policy;
    
}

@end












