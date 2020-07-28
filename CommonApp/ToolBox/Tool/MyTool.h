//
//  MyTool.h
//  goldmetal
//
//  Created by Cheese on 2017/1/19.
//  Copyright © 2017年 稻壳. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 读写删除相关的宏 -

@interface MyTool : NSObject
/**
 * @interfaceOrientation 输入要强制转屏的方向
 */
+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation;
#pragma mark 去掉null等字符
+ (NSString *)builtDataString:(id)dataStr;

+ (void)setSetingDefaultValue;

+(void)drawLineAtSuperView:(UIView*)superView andTopOrDown:(int)type andHeight:(CGFloat)height andColor:(UIColor*)color andFrame:(CGRect)frame;

#pragma mark - 获取当前天数
+(NSString *)getNowDayString;
//一个星期前的日期
+(NSString*)timeformat_oneWeekAgo;
//三天以后
+(NSString*)timeformat_threeDayAfter;



+(double)nowTimeTemp;//获取当前时间戳

+(NSString *)middleTimeWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

+(NSString*)timeformat_monthDay:(double)time;

+ (NSString *)decimal2PWithFormat:(CGFloat)floatValue;

+ (NSString*)priceFormat:(NSString*)price;

+ (NSString *)decimalPriceWithCode:(NSString *)code floatValue:(CGFloat)floatValue;

+ (BOOL)isPureFloat:(NSString *)string;

+(CGFloat)changeMinutesWithStartTime:(NSString*)starttime  MiddleTime:(NSString*)middletime EndTime:(NSString*)endtime Vertical:(int)vertical Type:(int)type;

+(NSArray*)changeTimesWithStartTime:(NSString*)starttime MiddleTime:(NSString*)middletime EndTime:(NSString*)endtime Vertical:(int)vertical;

+ (UIImage*)dottedImageWithStartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint Color:(UIColor *)color Width:(int)width ;

+(void)createCacheWithFileName:(NSString*)filename Path:(NSString*)path Content:(NSDictionary*)content;

+(NSDictionary*)readCacheWithFileName:(NSString*)filename Path:(NSString*)path;

+(NSTimeInterval)compareWithTime:(NSDate*)timeOne TimeTow:(NSDate*)timeTow;

+(NSString*)timeforMin:(double)time;

+(NSString*)timeFormat_ShortHourStyle:(double)time;

+(double)timeformat_shortTime:(NSString *)time;

+(NSInteger)timeNumberWithType:(NSString *)_type;

+ (NSURL *)URLWithImgStr:(NSString *)imgStr;

//计算一段文字的高度
+ (CGSize)stringText:(NSString *)text sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

//处理图片的方向信息
+ (UIImage *)fixOrientation:(UIImage *)aImage ;

//判断是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string;

//根据key删除偏好设置里的存储
+ (void)removeValueforKey:(NSString *)key;

//根据key写入数据到偏好设置
+ (void)writeValue:(id)value forKey:(NSString *)key;

//根据key读取偏好设置里的数据
+ (id)readValueForKey:(NSString *)key;

+ (NSString *)getStringFromObj:(id)obj;

+ (float)getWidthWithStr:(NSString *)str andFont:(UIFont *)font;


/**
 *
 *  显示上下箭头
 *  @param upValue >0向上，<0向下，＝0隐藏
 *
 */
+ (void)showArrowAtCenter:(CGPoint)center OnView:(UIView *)view upValue:(float)upValue;



// 设置字体
// 平方 细体
+ (UIFont *)lightFontWithSize:(CGFloat)size;
// 平方 粗体
+ (UIFont *)mediumFontWithSize:(CGFloat)size;
// 平方 常规
+ (UIFont *)regularFontWithSize:(CGFloat)size;

+ (UIFont *)semiboldFontWithSize:(CGFloat)size;

+ (UIFont *)dinMediumFontWithSize:(CGFloat)size;

+ (UIFont *)dinRegularFontWithSize:(CGFloat)size;

//弹框
+ (void)showAlertView:(NSString*)alertStr;
//弹出文字
+ (void)showToastWithStr:(NSString *)str;


+ (NSString *)idfa;

+ (NSString *)idfv;

+ (NSString *)getDeviceID;
    
+ (NSString *)guid;

//设置不同字体颜色
+(void)setTextColor:(UILabel *)label andFontNumber:(UIFont *)font andRangeStr:(NSString *)rangeStr andColor:(UIColor *)vaColor;

+ (void)modalLoginVcWithFromVc:(UIViewController *)vc;

// create label
+ (UILabel *)labelWithText:(NSString *)text;
+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font;
+ (UILabel *)labelWithFont:(UIFont *)font
                      text:(NSString *)text
                 textColor:(UIColor*)textColor;

// create button
+ (UIButton *)buttonWithTitle:(NSString *)title;
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont;
+ (UIButton *)buttonWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;
+ (UIButton *)buttonWithImage:(UIImage *)image
                selectedImage:(UIImage *)selectedImage;
+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                    titleFont:(UIFont *)titleFont
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage;

+ (BOOL)checkMobile:(NSString *)mobile;
+ (BOOL)checkContent:(NSString *)textContent check:(NSString *)checkStr;
+ (NSString *)imgArrToStr:(NSString *)jsonStr;
+ (NSString *)imgArrToStr2:(NSString *)jsonStr;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+(NSString *)convertToJsonData:(NSDictionary *)dict;
+(UIImage *)buttonImageFromColor:(UIColor *)color;
+ (NSString *)arrayToJSONString:(NSArray *)array;

+ (float)getHeightWithStr:(NSString *)str andFont:(UIFont *)font width:(CGFloat)width;
@end
