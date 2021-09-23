//
//  MyTool.m
//  goldmetal
//
//  Created by Cheese on 2017/1/19.
//  Copyright © 2017年 稻壳. All rights reserved.
//

#import "MyTool.h"
#import <AdSupport/AdSupport.h>
#import "VCManager.h"

#define arrow_up_view_tag 201608130
#define arrow_down_view_tag 201608131

#define kUserId @"userId"
#define reSetVersion @"1.0.0" //重置行情版本

@implementation MyTool
+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    
    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithInt:interfaceOrientation];
    
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    
}
#pragma mark 去掉null等字符
+ (NSString *)builtDataString:(id)dataStr
{
    if ([dataStr isEqual:[NSNull null]]) {
        return @"";
    }else if ([dataStr isKindOfClass:[NSNull class]]){
        return @"";
    }else if (dataStr == nil){
        return @"";
    }else if ([dataStr isKindOfClass:[NSString class]]) {
        if ([dataStr isEqualToString:@"<null>"] || [dataStr isEqualToString:@"(null)"]) {
            return @"";
        }else{
            return  dataStr;
        }
    }else if ([dataStr isKindOfClass:[NSNumber class]])
        {
        return [NSString stringWithFormat:@"%@",dataStr];;
        }
    else{
        return dataStr;
    }
}

#pragma mark 获取设置值
+(NSString *)getSeting:(NSString*)key{
    
    return [MyTool readValueForKey:key];
}
#pragma mark 设置配置值
+(void)setSeting:(NSString *)key Value:(id)value{
    [MyTool writeValue:value forKey:key];
}

NSString *bundleShortVersionString() {
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    return [dict objectForKey:@"CFBundleShortVersionString"];
}

+(void)drawLineAtSuperView:(UIView*)superView andTopOrDown:(int)type andHeight:(CGFloat)height andColor:(UIColor*)color andFrame:(CGRect)frame{
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = color;
    [superView addSubview:line];
    line = nil;
}

#pragma mark - 获取当前天数
+(NSString *)getNowDayString{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate date];
    
        //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [timeZone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSLog(@"%@", localeDate);
    NSString *nowTime=[formatter stringFromDate:localeDate];
    return nowTime;
}

+(NSString*)timeformat_oneWeekAgo{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    
    double startTimep=[[NSDate date] timeIntervalSince1970];
    double endTimep=startTimep-(60*60*24*7);
    NSDate *endDate=[NSDate dateWithTimeIntervalSince1970:endTimep];
    NSString *endTime=[dateFormatter stringFromDate:endDate];
    return endTime;
}

+(NSString*)timeformat_threeDayAfter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    
    double startTimep=[[NSDate date] timeIntervalSince1970];
    double endTimep=startTimep+(60*60*24*3);
    NSDate *endDate=[NSDate dateWithTimeIntervalSince1970:endTimep];
    NSString *endTime=[dateFormatter stringFromDate:endDate];
    return endTime;
}


+(double)nowTimeTemp{
    return [[NSDate date] timeIntervalSince1970];
}

+(NSString *)middleTimeWithStartTime:(NSString *)startTime endTime:(NSString *)endTime
{
    NSString *middleTime = @"18:00";
    NSArray *startArr=[startTime componentsSeparatedByString:@":"];
    NSArray *endArr=[endTime componentsSeparatedByString:@":"];
    if (startArr.count<2 || endArr.count<2)
        {
        return middleTime;
        }
    NSInteger startHour = [startArr[0] integerValue];
    NSInteger startMin = [startArr[1] integerValue];
    NSInteger mincount1 = startHour *60 + startMin;
    
    NSInteger endHour = [endArr[0] integerValue];
    NSInteger endMin = [endArr[1] integerValue];
    NSInteger mincount2 = endHour *60 + endMin;
    
    NSInteger mincount = 24*60-mincount1 + mincount2;
    if (endHour>12 && endHour<=24)
        {
        mincount = mincount2 - mincount1;
        }
    NSInteger min = mincount/2;
    NSInteger midMin = min%60+startMin;
    NSInteger midHour  = min/60+startHour;
    
    if (midMin >60)
        {
        midMin=midMin-60;
        midHour+=1;
        }
    middleTime = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)midHour,(long)midMin];
    return middleTime;
}

+(NSString*)timeformat_monthDay:(double)time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd HH:mm"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"time  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    NSLog(@"time =  %@",confromTimespStr);
    
    return confromTimespStr;
}

    //格式化小数 四舍五入类型 保留2位小数
+ (NSString *)decimal2PWithFormat:(CGFloat)floatValue {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"0.00"];
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatValue]];
}

+ (NSString*)priceFormat:(NSString*)price
{
    
    if (price.length>15 || price.length<=0) {
        return @"0.00";
    }
    @try {
            // 去掉后面的0
        if ([[price substringFromIndex:(price.length-1)] isEqualToString:@"0"] && [price rangeOfString:@"."].location!=NSNotFound) {
            price = [price substringToIndex:(price.length-1)];
        }
        if ([[price substringFromIndex:(price.length-1)] isEqualToString:@"0"] && price.length>0 && [price rangeOfString:@"."].location!=NSNotFound) {
            price = [price substringToIndex:(price.length-1)];
        }
        if ([[price substringFromIndex:(price.length-1)] isEqualToString:@"."] && price.length>0) {
            price = [price substringToIndex:(price.length-1)];
        }
        if (price.length>7) {
            price = [price substringToIndex:7];
                //price = [NSString stringWithFormat:@"%4.f",[price floatValue]];
        }
        if ([[price substringFromIndex:price.length-1] isEqualToString:@"."] && price.length>0) {
            price = [price substringToIndex:price.length-1];
        }
        if (fabs([price floatValue])<1 && [price floatValue]>0 && price.length>4) {
            price = [price substringToIndex:4];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
    return price;
}
    //根据code 格式化小数
+ (NSString *)decimalPriceWithCode:(NSString *)code floatValue:(CGFloat)floatValue {
    NSString *numStr = [MyTool pointWithCode:code];
    if (!numStr) {
        return [NSString stringWithFormat:@"%@",[NSNumber numberWithFloat:floatValue]];
    }
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *str = [NSString stringWithFormat:@"%@",[NSNumber numberWithFloat:floatValue]];
    if(notemptyStr(numStr)){
        [numberFormatter setPositiveFormat:numStr];
        str = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatValue]];
    }
    return str;
}
    //产品小数点位数
+ (NSString *)pointWithCode:(NSString *)code {
    if ([code containsString:@"au"]) {        //黄金 XAUUSD -2，
        return @"0.00";
    }
    else if ([code hasPrefix:@"i"]) {        //铁矿 i1801
        return @"0.0";
    }
    else {
        return @"0";
    }
}
    //判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString *)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+(CGFloat)changeMinutesWithStartTime:(NSString*)starttime  MiddleTime:(NSString*)middletime EndTime:(NSString*)endtime Vertical:(int)vertical Type:(int)type{
    if (![starttime containsString:@":"] || ![middletime containsString:@":"] || ![endtime containsString:@":"]) {
        return 0;
    }
    CGFloat startHour = [[starttime substringToIndex:[starttime rangeOfString:@":"].location] floatValue];
    CGFloat startMinute = [[starttime substringFromIndex:[starttime rangeOfString:@":"].location+1] floatValue];
    CGFloat endHour = [[endtime substringToIndex:[endtime rangeOfString:@":"].location] floatValue];
    CGFloat endMinute = [[endtime substringFromIndex:[endtime rangeOfString:@":"].location+1] floatValue];
    
    CGFloat middleHour = 0;
    CGFloat middleMinute = 0;
    CGFloat middleNextHour = 0;
    CGFloat middleNextMinute = 0;
    NSString *middle;
    NSString *middleNext;
    if ([middletime rangeOfString:@"/"].location != NSNotFound) {
        middle = [middletime substringToIndex:[middletime rangeOfString:@"/"].location];
        middleNext = [middletime substringFromIndex:[middletime rangeOfString:@"/"].location+1];
    }else{
        middle = middletime;
        middleNext = middletime;
    }
    
    middleHour = [[middle substringToIndex:[middle rangeOfString:@":"].location] floatValue];
    middleMinute = [[middle substringFromIndex:[middle rangeOfString:@":"].location+1] floatValue];
    middleNextHour = [[middleNext substringToIndex:[middleNext rangeOfString:@":"].location] floatValue];
    middleNextMinute = [[middleNext substringFromIndex:[middleNext rangeOfString:@":"].location+1] floatValue];
    
    
    if (endHour<middleNextHour) {
        endHour = 24 + endHour;
    }
    if (middleHour<startHour) {
        middleHour = 24 + middleHour;
    }
    CGFloat upHours = ((middleHour+middleMinute/60) - (startHour+startMinute/60));
    CGFloat downHours = ((endHour+endMinute/60) - (middleNextHour+middleNextMinute/60));
    CGFloat upfen = upHours * 60;
    CGFloat downfen = downHours * 60;
    if (type<=0) {
        return upfen;
    }
    return  downfen;
}

+(NSArray*)changeTimesWithStartTime:(NSString*)starttime MiddleTime:(NSString*)middletime EndTime:(NSString*)endtime Vertical:(int)vertical{
    if (![starttime containsString:@":"] || ![middletime containsString:@":"] || ![endtime containsString:@":"]) {
        return @[];
    }
    CGFloat startHour = [[starttime substringToIndex:[starttime rangeOfString:@":"].location] floatValue];
    CGFloat startMinute = [[starttime substringFromIndex:[starttime rangeOfString:@":"].location+1] floatValue];
    CGFloat endHour = [[endtime substringToIndex:[endtime rangeOfString:@":"].location] floatValue];
    CGFloat endMinute = [[endtime substringFromIndex:[endtime rangeOfString:@":"].location+1] floatValue];
    if (endHour<12) {
        endHour = 24 + endHour;
    }
    NSInteger startTimeCount = startHour*60+startMinute;
    NSInteger endTimeCount = endHour*60+endMinute;
    NSInteger subTime = endTimeCount-startTimeCount;
    if (startHour>endHour && startHour>12) {
        subTime=24*60-startTimeCount+endTimeCount;
    }
    CGFloat meanTime=(subTime *1.0 /vertical)/60;
    NSMutableArray *ar = [[NSMutableArray alloc]init];
    for (int i=0; i<=vertical; i++) {
        CGFloat t = (startHour+startMinute/60) + i*meanTime;
        if (t>24) {
            t = t - 24;
        }
        CGFloat m = t - (int)t;
        if (m>0) {
            m = m*60;
        }
        t = (int)t;
        NSString *tstr = [NSString stringWithFormat:@"%.0f",t];
        if (t<10) {
            tstr = [NSString stringWithFormat:@"0%.0f",t];
        }
        NSString *mstr = [NSString stringWithFormat:@"%.0f",m];
        if (m<10) {
            mstr = [NSString stringWithFormat:@"0%.0f",m];
        }
        NSString *ts = [NSString stringWithFormat:@"%@:%@",tstr,mstr];
        [ar addObject:ts];
        ts = nil;
        tstr = nil;
        mstr = nil;
        
    }
    return  ar;
}
    // 画虚线
+ (UIImage*)dottedImageWithStartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint Color:(UIColor *)color Width:(int)width {
        //NSLog(@"draw start.....");
    CGRect rect = CGRectMake(0, startPoint.y, width, 1);
    UIGraphicsBeginImageContext(rect.size);
        //UIGraphicsBeginImageContextWithOptions(rect.size, YES, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, width);
        // 如果是虚线
    CGFloat lengths[] = {3,3};
    CGContextSetLineDash(context, 0, lengths, 2);  //画虚线
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    const CGPoint point[] = {startPoint,endPoint};
    CGContextStrokeLineSegments(context, point, 2);  // 绘制
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(void)createCacheWithFileName:(NSString*)filename Path:(NSString*)path Content:(NSDictionary*)content{
        //获取应用程序沙盒的Library目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
    path = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/%@",path]];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    BOOL isdirectory = YES;
    if (![filemanager fileExistsAtPath:path isDirectory:&isdirectory]) {
        [filemanager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
        //NSLog(@"path:%@",path);
        //得到完整的文件名
    NSString *fullFileName=[path stringByAppendingPathComponent:filename];
    NSString *jsonstr = [content toJsonString];
    [jsonstr writeToFile:fullFileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
    fullFileName = nil;
    paths = nil;
    
}

+(NSDictionary*)readCacheWithFileName:(NSString*)filename Path:(NSString*)path{
        //获取应用程序沙盒的Library目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
    path = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/%@",path]];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    BOOL isdirectory = YES;
    if (![filemanager fileExistsAtPath:path isDirectory:&isdirectory]) {
        [filemanager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
        //NSLog(@"path:%@",path);
        //得到完整的文件名
    NSString *fullFileName=[path stringByAppendingPathComponent:filename];
    NSString *jsonstr = [NSString stringWithContentsOfFile:fullFileName encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dic = [jsonstr jsonStringToDictonary];
    fullFileName = nil;
    return dic;
}

+(NSTimeInterval)compareWithTime:(NSDate*)timeOne TimeTow:(NSDate*)timeTow{
    NSTimeInterval time = [timeOne timeIntervalSince1970];
    double timestamp = time;
    
    NSTimeInterval time2 = [timeTow timeIntervalSince1970];
    double timestampTow = time2;
    
    double timeInterVal = timestamp - timestampTow;
    return timeInterVal;
}

+(NSString*)timeforMin:(double)time{
    NSString *str = @"";
    NSDateComponents *com = [self getDateComponents:[NSDate dateWithTimeIntervalSince1970:time]];
    NSString *month = [NSString stringWithFormat:@"%ld",com.month];
    if (com.month<10) {
        month = [NSString stringWithFormat:@"0%ld",com.month];
    }
    NSString *day = [NSString stringWithFormat:@"%ld",com.day];
    if (com.day<10) {
        day = [NSString stringWithFormat:@"0%ld",com.day];
    }
    NSString *hour = [NSString stringWithFormat:@"%ld",com.hour];
    if (com.hour<10) {
        hour = [NSString stringWithFormat:@"0%ld",com.hour];
    }
    NSString *minute = [NSString stringWithFormat:@"%ld",com.minute];
    if (com.minute<10) {
        minute = [NSString stringWithFormat:@"0%ld",com.minute];
    }
    str = [NSString stringWithFormat:@"%ld.%@.%@ %@:%@",com.year,month,day,hour,minute];
    return str;
}

+(NSDateComponents*)getDateComponents:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
        // 年月日获得
    comps =[calendar components:(NSCalendarUnitYear |
                                 NSCalendarUnitMonth |
                                 NSCalendarUnitDay |
                                 NSCalendarUnitHour |
                                 NSCalendarUnitMinute |
                                 NSCalendarUnitSecond |
                                 NSCalendarUnitWeekday |
                                 NSCalendarUnitWeekOfMonth |
                                 NSCalendarUnitWeekOfYear)
                       fromDate:date];
    return comps;
}

+(NSString*)timeFormat_ShortHourStyle:(double)time{
    
    NSString *str = @"";
    NSDateComponents *com = [self getDateComponents:[NSDate dateWithTimeIntervalSince1970:time]];
    NSString *month = [NSString stringWithFormat:@"%ld",(long)com.month];
    if (com.month<10) {
        month = [NSString stringWithFormat:@"0%ld",(long)com.month];
    }
    NSString *day = [NSString stringWithFormat:@"%ld",(long)com.day];
    if (com.day<10) {
        day = [NSString stringWithFormat:@"0%ld",(long)com.day];
    }
    NSString *hour = [NSString stringWithFormat:@"%ld",(long)com.hour];
    if (com.hour<10) {
        hour = [NSString stringWithFormat:@"0%ld",(long)com.hour];
    }
    NSString *minute = [NSString stringWithFormat:@"%ld",(long)com.minute];
    if (com.minute<10) {
        minute = [NSString stringWithFormat:@"0%ld",(long)com.minute];
    }
    NSString *second = [NSString stringWithFormat:@"%ld",(long)com.second];
    if (com.second<10) {
        second = [NSString stringWithFormat:@"0%ld",(long)com.second];
    }
    str = [NSString stringWithFormat:@"%@-%@ %@:%@",month,day,hour,minute];
    return str;
}
+(double)timeformat_shortTime:(NSString *)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    NSString *year = [strDate substringToIndex:4];
    
    NSString *newTime=[NSString stringWithFormat:@"%@-%@:00",year,time];
    NSDate *date = [dateFormatter dateFromString:newTime];
    
    double timep=[date timeIntervalSince1970];
    return timep;
}
+(NSInteger)timeNumberWithType:(NSString *)_type
{
    NSInteger timeNumber = 0;
        //    NSArray *titles = @[@"分时",@"1分",@"5分",@"15分",@"30分",@"60分",@"4小时",@"日线",@"周线"];
    NSArray *timeArr = @[@"",@"10",@"2",@"3",@"4",@"5",@"9",@"6",@"7"];
    NSInteger numType = 0;
    if ([timeArr containsObject:_type])
        {
        for (int i = 0; i<timeArr.count; i++)
            {
            NSString *type = timeArr[i];
            if ([_type isEqualToString:type])
                {
                numType=i;
                break;
                }
            }
        }
    switch (numType) {
        case 0:
            timeNumber = 60;
            break;
        case 1:
            timeNumber = 60;
            break;
        case 2:
            timeNumber = 60*5;
            break;
        case 3:
            timeNumber = 60*15;
            break;
        case 4:
            timeNumber = 60*30;
            break;
        case 5:
            timeNumber = 60*60;
            break;
        case 6:
            timeNumber = 60*60*4;
            break;
        case 7:
            timeNumber = 60*60*24;
            break;
        case 8:
            timeNumber = 60*60*24*7;
            break;
            
        default:
            break;
    }
    return timeNumber;
}

+ (NSURL *)URLWithImgStr:(NSString *)imgStr
{
    NSURL *url = nil;
    NSInteger httpstr = [imgStr hasPrefix:@"http"];
    if (httpstr == 1) {
        url = [NSURL URLWithString:imgStr];
        
    }else{
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL, imgStr]];
    }
    return url;
}




+ (CGSize)stringText:(NSString *)text sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, maxW, font.lineHeight)];
    label.text = text;
    label.numberOfLines = 0;
    label.font = font;
    [label sizeToFit];
    return label.frame.size;
}

//处理图片的方向信息
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp) return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

//判断是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}


#pragma mark - 读写删除 -
+ (void)removeValueforKey:(NSString *)key{
    if ([MyTool readValueForKey:key]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}

+ (void)writeValue:(id)value forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults]  setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:key];
}

+ (id)readValueForKey:(NSString *)key{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (!obj) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithData:obj];
}

+ (NSString *)getStringFromObj:(id)obj{
    return obj?[NSString stringWithFormat:@"%@",obj]:@"";
}

+ (float)getWidthWithStr:(NSString *)str andFont:(UIFont *)font{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 9999, font.lineHeight)];
    label.text = str;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

+ (float)getHeightWithStr:(NSString *)str andFont:(UIFont *)font width:(CGFloat)width{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, font.lineHeight)];
    label.text = str;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.height;
}

+ (UIFont *)lightFontWithSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Light" size:size];
    if (!font) {
        font = [UIFont italicSystemFontOfSize:size];
    }
    return font;
}

+ (UIFont *)regularFontWithSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

+ (UIFont*)semiboldFontWithSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

+ (UIFont *)dinMediumFontWithSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"DINPro-Medium" size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}


+ (UIFont *)dinRegularFontWithSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"DINPro-Regular" size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

+ (UIFont *)mediumFontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:size];
    if (!font) {
        font = [UIFont boldSystemFontOfSize:size];
    }
    return font;
}

+ (void)showArrowAtCenter:(CGPoint)center OnView:(UIView *)view upValue:(float)upValue{
    UIImageView *upView = [view viewWithTag:arrow_up_view_tag];
    UIImageView *downView = [view viewWithTag:arrow_down_view_tag];
    float centerX = center.x;
    float centerY = center.y;
    float dy = 6;
    if (upView&&ABS(centerX-upView.center.x)>0.5) {
        [upView removeFromSuperview];
        [downView removeFromSuperview];
    }
    if (!upView) {
        float dw = 11;
        if (view.tag==20161201) {
            dw = 8;
        }
        upView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, dw, dw)];
        upView.image = [UIImage imageNamed:view.tag==20161130?@"price_arrow_white_up":@"price_arrow_up"];
        upView.center = CGPointMake(centerX, centerY+dy);
        upView.tag = arrow_up_view_tag;
        [view addSubview:upView];
        
        downView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, dw, dw)];
        downView.image = [UIImage imageNamed:view.tag==20161130?@"price_arrow_white_down":@"price_arrow_down"];
        downView.center = CGPointMake(centerX, centerY-dy);
        downView.tag = arrow_down_view_tag;
        [view addSubview:downView];
        
        upView.alpha = 0.4;
        downView.alpha = 0.4;
        [UIView animateWithDuration:0.9 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveEaseOut animations:^{
            upView.center = CGPointMake(centerX, centerY-dy);
            downView.center = CGPointMake(centerX, centerY+dy);
            upView.alpha = 1;
            downView.alpha = 1;
        } completion:^(BOOL finished) {
            if (!finished) {
                [upView removeFromSuperview];
                [downView removeFromSuperview];
            }
            upView.alpha = 0.2;
            downView.alpha = 0.2;
            upView.center = CGPointMake(centerX, centerY+dy);
            downView.center = CGPointMake(centerX, centerY-dy);
        }];
    }
    if (upValue<0) {
        upView.hidden = YES;
        downView.hidden = NO;
    }else if(upValue>0){
        upView.hidden = NO;
        downView.hidden = YES;
    }else{
        upView.hidden = YES;
        downView.hidden = YES;
    }
}

/**
 *
 *  此方法用于显示提示信息
 *  @alertStr 此参数为 提示信息
 *  @return 无返回值
 *
 */
+ (void)showAlertView:(NSString*)alertStr
{
    if (!alertStr) {
        return;
    }
    UIAlertView *tempAltView = [[UIAlertView  alloc]initWithTitle:@"" message:alertStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil ];
    [tempAltView show];
}

+ (void)showToastWithStr:(NSString *)str{
    if (!str||[str isEqualToString:@""]||[str isEqualToString:@"网络异常"]) {
        return;
    }
    UIFont *font = [UIFont systemFontOfSize:13];
    UILabel *toastVeiw = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MIN(mainWidth-40, [MyTool getWidthWithStr:str andFont:font]+40), 40)];
    toastVeiw.textAlignment = NSTextAlignmentCenter;
    toastVeiw.clipsToBounds = YES;
    toastVeiw.text = str;
    toastVeiw.font = font;
    toastVeiw.textColor = [UIColor whiteColor];
    toastVeiw.center = CGPointMake([[UIScreen mainScreen] bounds].size.width*0.5, [[UIScreen mainScreen] bounds].size.height*0.5);
    toastVeiw.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    toastVeiw.layer.cornerRadius = 5;
    [[UIApplication sharedApplication].keyWindow addSubview:toastVeiw];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [toastVeiw removeFromSuperview];
    });
}

+ (NSString *)idfa{
    NSString *idfaStr;
    Class theClass=NSClassFromString(@"ASIdentifierManager");
    if (theClass)
    {
        idfaStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }else{
        idfaStr = @"";
    }
    return idfaStr;
}

+ (NSString *)idfv
{
    NSString *idfvStr = @"";
    idfvStr = [UIDevice currentDevice].identifierForVendor.UUIDString;
    return idfvStr;
}

+ (NSString *)getDeviceID
{
    NSString *deviceIDStr = [self idfa];

    NSString *tempStr = deviceIDStr;
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"0" withString:@""];
    tempStr  = [tempStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (tempStr.length == 0) {
        deviceIDStr = [self idfv];
    }
    
    return deviceIDStr;
}
    
    //获取guid
+ (NSString*)guid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

//设置不同字体颜色
+(void)setTextColor:(UILabel *)label andFontNumber:(UIFont *)font andRangeStr:(NSString *)rangeStr andColor:(UIColor *)vaColor
{
    if (label.text.length > 0 && rangeStr.length > 0) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
        NSRange range = [label.text rangeOfString:rangeStr];
        //设置字号
        [str addAttribute:NSFontAttributeName value:font range:range];
        //设置文字颜色
        [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
        label.attributedText = str;
    }

}

#pragma mark - modal loginVc -
+ (void)modalLoginVcWithFromVc:(UIViewController *)vc{

}

// create Label
+ (UILabel *)labelWithText:(NSString *)text{
    return [self labelWithText:text
                          font:[MyTool regularFontWithSize:14 * ScaleX]];
}

+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font{
    return [self labelWithFont:font
                          text:text
                     textColor:UIColorFromRGB(0x333333)];
}

+ (UILabel *)labelWithFont:(UIFont *)font
                      text:(NSString *)text
                 textColor:(UIColor*)textColor{
    UILabel *label = [[UILabel alloc] init];
    if (font) {
        label.font = font;
    }
    if (text) {
        label.text = text;
    }
    if (textColor) {
        label.textColor = textColor;
    }
    
    return label;
}

+ (UIButton *)buttonWithTitle:(NSString *)title{
    return [self buttonWithTitle:title titleColor:UIColorFromRGB(0x333333)];
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor{
    return [self buttonWithTitle:title titleColor:titleColor titleFont:[MyTool regularFontWithSize:14 * ScaleX]];
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont{
    return  [self buttonWithTitle:title titleColor:titleColor titleFont:titleFont image:nil selectedImage:nil];
}

+ (UIButton *)buttonWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage{
    return [self buttonWithTitle:title titleColor:UIColorFromRGB(0x333333) titleFont:[MyTool regularFontWithSize:14 * ScaleX] image:image selectedImage:selectedImage];
}

+ (UIButton *)buttonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage{
    return [self buttonWithTitle:nil image:image selectedImage:selectedImage];
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                    titleFont:(UIFont *)titleFont
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    
    return button;
}

+ (BOOL)checkMobile:(NSString *)mobile{
    
    NSString *phoneRegex = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)checkContent:(NSString *)textContent check:(NSString *)checkStr{
    NSPredicate *checkTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",checkStr];
    return [checkTest evaluateWithObject:textContent];
}


+ (NSString *)imgArrToStr:(NSString *)jsonStr {
    if (jsonStr) {
//        id tmp = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        id tmp = jsonStr;
        if (tmp) {
            if ([tmp isKindOfClass:[NSArray class]]) {
                return [NSString stringWithFormat:@"%@",[MyTool URLWithImgStr:[[tmp objectAtIndexCheck:0] objectForKey:@"file"]]];
                //                return [NSString stringWithFormat:@"%@/%@",BASE_PIC_URL,[[tmp objectAtIndexCheck:0] objectForKey:@"file"]];
                
            } else if([tmp isKindOfClass:[NSString class]] ) {
                return [NSString stringWithFormat:@"%@%@",BASE_PIC_URL,tmp];
                
            } else if([tmp isKindOfClass:[NSDictionary class]] ){
                return [NSString stringWithFormat:@"%@%@",BASE_PIC_URL,tmp[@"file"]];
            } else{
                return nil;
            }
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}
+ (NSString *)imgArrToStr2:(NSString *)jsonStr {
    if (jsonStr) {
        id tmp = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        if (tmp) {
            if ([tmp isKindOfClass:[NSArray class]]) {
                return [NSString stringWithFormat:@"%@",[MyTool URLWithImgStr:[[tmp objectAtIndexCheck:0] objectForKey:@"file"]]];
                //                return [NSString stringWithFormat:@"%@/%@",BASE_PIC_URL,[[tmp objectAtIndexCheck:0] objectForKey:@"file"]];
                
            } else if([tmp isKindOfClass:[NSString class]] ) {
                return [NSString stringWithFormat:@"%@%@",BASE_PIC_URL,tmp];
                
            } else if([tmp isKindOfClass:[NSDictionary class]] ){
                return [NSString stringWithFormat:@"%@%@",BASE_PIC_URL,tmp[@"file"]];
            } else{
                return nil;
            }
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
// 字典转json字符串方法

+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

+ (NSString *)arrayToJSONString:(NSArray *)array

{
    
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableString * mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    NSRange range3 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\\" withString:@"" options:NSLiteralSearch range:range3];
    return mutStr;
}

+ (UIImage *)buttonImageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, mainWidth, mainHeight);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
