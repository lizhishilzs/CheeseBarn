//
//  Interface.h
//  goldmetal
//
//  Created by Cheese on 2017/1/19.
//  Copyright © 2017年 稻壳. All rights reserved.
//  网络请求

/**
 请求方法的类型
 */
typedef NS_ENUM(NSUInteger, DKInterfaceRequestType) {
    DKInterfaceRequestTypeGet,
    DKInterfaceRequestTypePost,
    DKInterfaceRequestTypeDelete
};

#define DKInterfaceStatusSuccess @"OK"
/**
 数据状态
 */
typedef NS_ENUM(NSUInteger, DKInterfaceStatus) {
    DKInterfaceStatusOK = 1, // 请求数据成功
};

/**
 平台类型
 */
typedef NS_ENUM(NSUInteger,PlatformType) {
    PlatformTypeNone,         //访问自己
};

/*
 API地址
  **/
//http://ip-73-farm-1.coralcodes.com/api
//http://ip-29-shanhuquan-app.coralcodes.com
//http://app.shanhuquan.com
#define BASE_URL     @"http://ip-29-laboratory-app.coralcodes.com"


/*
 图片开发服务器 : http://qihuo-test.oss-cn-shanghai.aliyuncs.com/
 图片正式服务器 : http://qihuo-product.oss-cn-shanghai.aliyuncs.com/ http://ip-29-shanhuquan-app.coralcodes.com
 http://app.shanhuquan.com
 **/
#define BASE_PIC_URL @"http://ip-29-laboratory-app.coralcodes.com"


/**
 H5开发服务器 : http://106.15.158.85:800/
 H5正式服务器 : http://qihuo.DKsudai.com/ https://ip-29-shanhuquan-front.coralcodes.com
 https://www.shanhuquan.com 
 */
#define BASE_WEB_URL @"http://ip-29-laboratory-app.coralcodes.com" //

#define Shake_Open 0 // 摇一摇切换环境开关,1为开 0为关

#import <Foundation/Foundation.h>

/**
 请求回调block
 
 @param isRequestSuccess 请求是否成功
 @param object 返回的对象
 @param eMsg 请求失败的错误信息
 */
typedef void (^requestBlock)(BOOL isRequestSuccess, NSDictionary *object, NSString *eMsg);
typedef void(^ReqCompletion)(void);

@interface Interface : NSObject

@property(nonatomic, strong)AFHTTPSessionManager *shareManger;

+ (Interface *)instance;

@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic, strong) NSString *baseWebUrl; // H5服务器

/**
 网络请求

 @param method 请求方式 get、post
 @param baseUrl baseUrl
 @param urlStirng 接口
 @param parameters 参数
 @param type 请求平台
 @param isEncrypted 参数是否加密
 @param finished 请求完成回调
                   1.请求数据成功，且success == YES,返回(data,nil)
                   2.请求数据成功，且success == NO,返回(errorCode,errorInfo)
                   3.请求数据成功，数据结构不对,返回(nil,errorInfo)
                   4.请求数据失败,返回(nil,errorInfo)
 */
- (void)request:(DKInterfaceRequestType)method
        baseUrl:(NSString *)baseUrl
      urlString:(NSString *)urlStirng
     parameters:(id)parameters
   platformType:(PlatformType)type
    isEncrypted:(BOOL)isEncrypted
       finished:(void (^)(id responseObject, NSString *error))finished;

- (void)request:(DKInterfaceRequestType)method
        baseUrl:(NSString *)baseUrl
      urlString:(NSString *)urlStirng
     parameters:(id)parameters
   platformType:(PlatformType)type
    isEncrypted:(BOOL)isEncrypted
finishedWithMsg:(void (^)(id responseObject, NSString *error))finished;

// 参数不加密，PlatformTypeNone
- (void) request:(DKInterfaceRequestType)method
         baseUrl:(NSString *)baseUrl
       urlString:(NSString *)urlStirng
      parameters:(id)parameters
        finished:(void(^)(id responseObject,NSString *error))finished;


/**
 网络请求

 @param method 请求方式 get、post
 @param baseUrl baseUrl
 @param urlStirng 接口
 @param parameters 参数
 @param finished 请求完成回调，包括服务器返回所有信息
 */
- (void) request:(DKInterfaceRequestType)method
         baseUrl:(NSString *)baseUrl
       urlString:(NSString *)urlStirng
      parameters:(id)parameters
 finishedWithMsg:(void (^)(id responseObject, NSString *error))finished;
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
  constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                   progress:(void (^)(NSProgress *uploadProgress))uploadProgress
              callBackBlock:(requestBlock)callBackBlock;

//form形式
- (void)requestform:(DKInterfaceRequestType)method
            baseUrl:(NSString *)baseUrl
          urlString:(NSString *)urlStirng
         parameters:(id)parameters
           finished:(void (^)(id, NSString *))finished;
@end





