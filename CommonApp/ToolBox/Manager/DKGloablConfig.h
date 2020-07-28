//
//  DKGloablConfig.h
//  CheeseProject
//
//  Created by Cheese on 2017/10/23.
//  Copyright © 2017年 CheeseProject. All rights reserved.
//

//宏定义集合

#import <Foundation/Foundation.h>

///
#define LTRGBA(r, g, b, a)        \
[UIColor colorWithRed:(CGFloat)r/255.0f \
green:(CGFloat)g/255.0f \
blue:(CGFloat)b/255.0f \
alpha:(CGFloat)a]

#define LTRGB(r, g, b)              LTRGBA(r, g, b, 1)
#define KLineBoxBG                  LTRGB(31, 31, 31)
#define LTBgColor                   UIColorFromRGB(0xf2f2f2)//浅灰色背景颜色
#define LTTitleColor                UIColorFromRGB(0x464646)//黑色字体

#define LTKLineGreen                UIColorFromRGB(0x06A969)//k线跌
#define LTKLineRed                  UIColorFromRGB(0xEB4A5E)//k线涨
#define LTSubTitleColor             UIColorFromRGB(0x999999)//灰色字体
#define BownColor                   UIColorFromRGB(0xBB8B7D)
#define LTLineColor                 UIColorFromRGB(0xE6E7EA)//灰色线条颜色
#define LTSureFontBlue              UIColorFromRGB(0x4877E6)//确定按钮字体颜色

#define UD_ObjForKey(key)               [MyTool readValueForKey:key]
#define UD_SetObjForKey(obj,key)        [MyTool writeValue:obj forKey:key]

#define WS(weakSelf) __weak typeof(self) weakSelf = self;


#define kRedColor       UIColorFromRGB(0xFF0000)
#define kGreenColor     UIColorFromRGB(0x2CC593)
#define kBlueColor      UIColorFromRGB(0x187BB2)
#define kWhiteColor     UIColorFromRGB(0xFFFFFF)
#define k666666Color    UIColorFromRGB(0x666666)
#define kPinkColor      UIColorFromRGB(0xFF847B)
#define kLineColor      UIColorFromRGB(0xDDDDDD)
#define kGrayColor      UIColorFromRGB(0x999999)
#define k333333Color    UIColorFromRGB(0x333333)
#define kBlackColor     UIColorFromRGB(0x000000)


#define Lit_iphone6W       375.0
#define Lit_iphone6H       667.0
#define mainWidth     [[UIScreen mainScreen] bounds].size.width
#define mainHeight       [[UIScreen mainScreen] bounds].size.height
#define ScaleX   mainWidth/375
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_X (IS_IPHONE && mainHeight == 812.0)
#define X_foot   39
#define X_head   44

/**定义颜色的宏*/
//颜色 16进制 例如: UIColorFromRGB(0x2b2b2b)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//带透明度的颜色
#define UIColorFromRGBA(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

// console log
#ifdef DEBUG
#if TARGET_IPHONE_SIMULATOR
#define DKLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define DKLog(...) printf("%s 第%d行 \n %s\n\n",__func__,__LINE__,[[NSString stringWithFormat:__VA_ARGS__]UTF8String])
#endif
#else
#define DKLog(...)
#endif

#define TabBar_Height  44
#define NavBar_Height  44
#define StatusBar_Height  [[UIApplication sharedApplication] statusBarFrame].size.height


extern NSString *DKDeviceToken;
extern NSString *DKURLSCHEME; // 协议头
extern NSString *DKURLJumpHost; // jump动作
extern NSString *DKURLOpenWeb; // 跳H5

