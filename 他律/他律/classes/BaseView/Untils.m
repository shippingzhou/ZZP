//
//  Untils.m
//  LoveU
//
//  Created by 肖亮 on 15/11/10.
//  Copyright © 2015年 肖亮. All rights reserved.
//

#import "Untils.h"
#import <CoreLocation/CoreLocation.h>
#import "UIImage+Extension.h"
#import <SystemConfiguration/CaptiveNetwork.h>
//#import "RichLabel.h"
#import <CoreText/CoreText.h>
#import <CommonCrypto/CommonCryptor.h>

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@interface Untils()  <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation Untils

+(instancetype)defaultUntils
{
    static Untils *untils = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        untils = [[[self class] alloc] init];
    });
    
    return untils;
}

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        self.userLat = 0.0;
        self.userLng = 0.0;
    }
    return self;
}


#pragma mark -  获取精度维度
-(void)gainUserLatAndLng:(UserLatAndLng)latAndLng
{
    _latAndLng = latAndLng;
    
    self.locationManager = [[CLLocationManager alloc] init];
    // 设置定位精度，十米，百米，最好
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    self.locationManager.distanceFilter = 100.f;
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    // 开始时时定位
    [self.locationManager startUpdatingLocation];
}


#pragma mark - 处理一张图片模糊化

-(UIImage *)bandBlurImageWith:(UIImage *)image andGaussBlur:(float)blur andColor:(UIColor *)color
{
    CGFloat ratio = image.size.width / J_SCREEN_WIDTH;
    float width = J_SCREEN_WIDTH;
    CGRect frame  = CGRectMake(0, 0, width, width);
    frame.size.width  *= ratio;
    frame.size.height *= ratio;
    frame.origin.x *= ratio;
    frame.origin.y *= ratio;
    
    UIImage *blurImage = [image gaussBlur:blur <= 0 ? 0.5 : blur];
    
    UIImage *mask = [UIImage fastImageWithContentsOfFile:@"circle.png"];
    UIGraphicsBeginImageContext(image.size);
    {
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext() , [color CGColor]);
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, frame.size.width, frame.size.height));
        [mask drawInRect:frame];
        mask = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();

    UIImage *tmp = [image maskedImage:mask];
    
    UIGraphicsBeginImageContext(blurImage.size);
    {
        [blurImage drawAtPoint:CGPointZero];
        [tmp drawInRect:CGRectMake(0, 0, blurImage.size.width, blurImage.size.height)];
        tmp = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return tmp;
}

/******************************************************************************
 函数名称 : + (NSData *)dataWithBase64EncodedString:(NSString *)string
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 :
 ******************************************************************************/
+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        //        [NSException raise:NSInvalidArgumentException format:nil];
        if ([string length] == 0)
            return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

/******************************************************************************
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

#pragma mark - 压缩图片

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - 截取一张以图片中心的正方形图片的地址
-(UIImage *)cutCenterImage:(UIImage *)image size:(CGSize)size{
    CGSize imageSize = image.size;
    CGRect rect;
    //根据图片的大小计算出图片中间矩形区域的位置与大小
    if (imageSize.width > imageSize.height) {
        float leftMargin = (imageSize.width - imageSize.height) * 0.5;
        rect = CGRectMake(leftMargin, 0, imageSize.height, imageSize.height);
    }else{
        float topMargin = (imageSize.height - imageSize.width) * 0.5;
        rect = CGRectMake(0, topMargin, imageSize.width, imageSize.width);
    }
    
    CGImageRef imageRef = image.CGImage;
    //截取中间区域矩形图片
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, rect);
    
    UIImage *tmp = [[UIImage alloc] initWithCGImage:imageRefRect];
    CGImageRelease(imageRefRect);
    
    UIGraphicsBeginImageContext(size);
    CGRect rectDraw = CGRectMake(0, 0, size.width, size.height);
    [tmp drawInRect:rectDraw];
    // 从当前context中创建一个改变大小后的图片
    tmp = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return tmp;
}

- (NSString *)updateTimeForRow:(NSString *)clientTime {
    long minute = 60000;
    long hour = 3600000;
    long day = 86400000;
    long ten_day = 864000000;
    long year = 31536000000;
    
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970] * 1000;
    
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = [clientTime doubleValue];
    // 时间差
    NSTimeInterval minusTimestamp = currentTime - createTime;
    if (minusTimestamp < minute) {
        return @"刚刚";
    } else if (minusTimestamp >= minute && minusTimestamp <= hour) {
        minusTimestamp = minusTimestamp / minute;
        NSInteger timestamp = (NSInteger)minusTimestamp;
        return [NSString stringWithFormat:@"%zd分钟前",timestamp];
    } else if (minusTimestamp >= hour && minusTimestamp < day) {
        minusTimestamp = minusTimestamp / hour;
        NSInteger timestamp = (NSInteger)minusTimestamp;
        return [NSString stringWithFormat:@"%zd小时前",timestamp];
    } else if (minusTimestamp >= day && minusTimestamp < ten_day) {
        minusTimestamp = minusTimestamp / day;
        NSInteger timestamp = (NSInteger)minusTimestamp;
        return [NSString stringWithFormat:@"%zd天前",timestamp];
    } else if (minusTimestamp >= ten_day && minusTimestamp < year) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd"];
        /////  将需要转换的时间转换成 NSDate 对象
        NSDate *needFormatDate = [NSDate dateWithTimeIntervalSince1970: createTime/1000.0];
        NSString *tempDate = [dateFormatter stringFromDate:needFormatDate];
        return [NSString stringWithFormat:@"%@",tempDate];
    } else if (minusTimestamp >= year) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        /////  将需要转换的时间转换成 NSDate 对象
        NSDate *needFormatDate = [NSDate dateWithTimeIntervalSince1970: createTime/1000.0];
        NSString *tempDate = [dateFormatter stringFromDate:needFormatDate];
        return [NSString stringWithFormat:@"%@",tempDate];
    }else {
        return @"";
    }
}

//转化时间
- (NSString *)getCurrentTimeFromClientTime:(NSString *)clientTime {
    long minute = 60000;
    long hour = 3600000;
    long day = 86400000;
    long ten_day = 864000000;
    long year = 31536000000;
    
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970] * 1000;
    
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = [clientTime doubleValue];
    // 时间差
    NSTimeInterval minusTimestamp = currentTime - createTime;
    if (minusTimestamp < minute) {
        return @"刚刚";
    } else if (minusTimestamp >= minute && minusTimestamp <= hour) {
        minusTimestamp = minusTimestamp / minute;
        NSInteger timestamp = (NSInteger)minusTimestamp;
        return [NSString stringWithFormat:@"%zd分钟前",timestamp];
    } else if (minusTimestamp >= hour && minusTimestamp < day) {
        minusTimestamp = minusTimestamp / hour;
        NSInteger timestamp = (NSInteger)minusTimestamp;
        return [NSString stringWithFormat:@"%zd小时前",timestamp];
    } else if (minusTimestamp >= day && minusTimestamp < ten_day) {
        minusTimestamp = minusTimestamp / day;
        NSInteger timestamp = (NSInteger)minusTimestamp;
        return [NSString stringWithFormat:@"%zd天前",timestamp];
    } else if (minusTimestamp >= ten_day && minusTimestamp < year) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd"];
        /////  将需要转换的时间转换成 NSDate 对象
        NSDate *needFormatDate = [NSDate dateWithTimeIntervalSince1970: createTime/1000.0];
        NSString *tempDate = [dateFormatter stringFromDate:needFormatDate];
        return [NSString stringWithFormat:@"%@",tempDate];
    } else if (minusTimestamp >= year) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        /////  将需要转换的时间转换成 NSDate 对象
        NSDate *needFormatDate = [NSDate dateWithTimeIntervalSince1970: createTime/1000.0];
        NSString *tempDate = [dateFormatter stringFromDate:needFormatDate];
        return [NSString stringWithFormat:@"%@",tempDate];
    }else {
        return @"";
    }
}

/**
 *  将服务器时间戳转化成显示时间
 *
 *  @return 转化后的时间
 **/
-(NSString *)handleShowTimeStringByClientTime:(NSString *)clientTime
{
    NSString *showTime = nil;

    NSString * subTime = [clientTime substringWithRange:NSMakeRange(0, clientTime.length)];
    double timeint = subTime.doubleValue;
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSDate * nowDate = [NSDate date];
    /////  将需要转换的时间转换成 NSDate 对象
    NSDate *needFormatDate = [NSDate dateWithTimeIntervalSince1970: timeint/1000.0];
    /////  取当前时间和转换时间两个日期对象的时间间隔
    /////  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
    NSTimeInterval Subtime = [nowDate timeIntervalSinceDate:needFormatDate];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:@"MM-dd"];
    //// 再然后，把间隔的秒数折算成天数和小时数：
    //    如一个小时内的显示为 多少分钟前 如 32分钟前
    Subtime = Subtime - 100;
    if (Subtime <= 60) {
        showTime = @"刚刚";
    }
    else if (Subtime > 60 && Subtime <= 60*60) {
        float mins = ceil(Subtime/60);
        showTime = [NSString stringWithFormat:@"%.0f分钟前",mins];
    }//    超过1小时，没超过1天的，显示 多少小时前，如 5小时前
    else if (Subtime > 60*60 && Subtime < 60*60*24)
    {
        float time = ceil(Subtime / (60*60));
        
        showTime = [NSString stringWithFormat:@"%.0f小时前",time];
    }//    超过1天的，显示 多少天前，如12天前
    else if (Subtime >= 60*60*24 && Subtime < 60*60*24*30)
    {
        float timeint = ceil(Subtime / (60*60*24));
        
        showTime = [NSString stringWithFormat:@"%.0lf天前",timeint];
    }//    超过30天的，显示 MM-dd
    else
    {
        [dateFormatter setDateFormat:@"MM-dd"];
        NSString *tempDate = [dateFormatter stringFromDate:needFormatDate];
        showTime = [NSString stringWithFormat:@"%@",tempDate];
    }
    
    return showTime;
}

-(NSString *)showTimeStringByClientTime:(NSString *)clientTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[clientTime doubleValue]/1000];
  
    NSString *dat = [formatter stringFromDate:date1];

    return dat;
}

//显示服务器时间
-(NSString *)showCurrentTimeStringByClientTime:(NSString *)clientTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[clientTime doubleValue]/1000];
    
    NSString *dat = [formatter stringFromDate:date1];
    
    return dat;
}

//计算文字高度
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width andHeight:(float)height isBoldMT:(BOOL)isBoldMT
{
    if (isBoldMT == YES) {
        CGSize sizeToFit = [value sizeWithFont:[UIFont fontWithName:K_BoldMT size:fontSize] constrainedToSize:CGSizeMake(width, height) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
        return sizeToFit.height;
    }else {
        CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, height) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
        return sizeToFit.height;
    }
}

//计算带emoji表情文字高度
- (CGFloat)heightWithEmojiText:(NSString *)text font:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    // Get text
    CFMutableAttributedStringRef attrString =CFAttributedStringCreateMutable(kCFAllocatorDefault,0);
    CFAttributedStringReplaceString (attrString,CFRangeMake(0,0), (CFStringRef) text);
    CFIndex stringLength = CFStringGetLength((CFStringRef) attrString);
    
    // Change font
    CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef) font.fontName, font.pointSize,NULL);
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, stringLength), kCTFontAttributeName, ctFont);
    
    // Calc the size
    CTFramesetterRef framesetter =CTFramesetterCreateWithAttributedString(attrString);
    CFRange fitRange;
    CGSize frameSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, stringLength), NULL, CGSizeMake(width, CGFLOAT_MAX), &fitRange);
    CFRelease(ctFont);
    CFRelease(framesetter);
    CFRelease(attrString);
    return frameSize.height;
}

//计算文字宽度
-(float) widthForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width andHeight:(float)height isBoldMT:(BOOL)isBoldMT {
    if (isBoldMT) {
        CGSize maxSize = CGSizeMake(width, height);
        CGSize contentSize = [value boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont fontWithName:K_BoldMT size:fontSize]} context:nil].size;
        return contentSize.width;
    }else {
        CGSize maxSize = CGSizeMake(width, height);
        CGSize contentSize = [value boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;
        return contentSize.width;
    }
    
}

/**
 *  订单时间显示
 *
 *  @param clientTime 服务器时间戳
 *  @return 转化后的时间
 **/
-(NSString *)handleOrderShowTimeStringByClientTime:(NSString *)clientTime
{
    NSString *showTime = nil;
    
    NSString * subTime = [clientTime substringWithRange:NSMakeRange(0, clientTime.length)];
    double timeint = subTime.doubleValue;
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSDate *needFormatDate = [NSDate dateWithTimeIntervalSince1970:timeint];

    showTime = [dateFormatter stringFromDate:needFormatDate];
    
    return showTime;
}

-(NSString *)handleActivitiShowTimeStringByClientTime:(NSString *)clientTime
{
    NSString *showTime = nil;
    
    NSString * subTime = [clientTime substringWithRange:NSMakeRange(0, clientTime.length)];
    double timeint = subTime.doubleValue/1000;
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY.MM.dd"];
    
    NSDate *needFormatDate = [NSDate dateWithTimeIntervalSince1970:timeint];
    
    showTime = [dateFormatter stringFromDate:needFormatDate];
    
    return showTime;
}

//创建距离多少年前的date
-(NSDate *)createDateByLaterTimeInt:(int)laterInt
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *timeString = [formatter stringFromDate:[NSDate date]];
    NSArray *timeArray = [timeString componentsSeparatedByString:@"-"];
    NSString *yearStr = [timeArray objectAtIndex:0];
    //当前时间的laterInt年前
    int laterEight = [yearStr intValue] - laterInt;
    NSMutableArray *mutablArray = [NSMutableArray arrayWithArray:timeArray];
    [mutablArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",laterEight]];
    
    NSMutableString *mutableTimeStr = [[NSMutableString alloc] initWithCapacity:5];
    
    for (int i = 0; i < mutablArray.count; i++) {
        if (i == 0) {
            [mutableTimeStr appendFormat:@"%@",[mutablArray objectAtIndex:i]];
        }else
        {
            [mutableTimeStr appendFormat:@"-%@",[mutablArray objectAtIndex:i]];
        }
    }
    NSDate *date = [formatter dateFromString:mutableTimeStr];
    return date;
}

//名字验证
- (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{4,16}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

//判断是否包含emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
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



//空格判断
-(BOOL)isEmpty:(NSString *) str {
    NSRange range = [str rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES; //yes代表包含空格
    }else {
        return NO; //反之
    }
}
-(BOOL) validateForSpace:(NSString *)space {
    NSString *spaceRegex = @"^[^ ]{6,16}$";
    NSPredicate *spacePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",spaceRegex];
    BOOL B = [spacePredicate evaluateWithObject:space];
    return B;
}

//手机号码验证
- (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13，14(57), 17(0678), 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(17[0678])|(14[57])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

////身份证号
//- (BOOL) validateIdentityCard: (NSString *)identityCard
//{
//    BOOL flag;
//    if (identityCard.length <= 0) {
//        flag = NO;
//        return flag;
//    }
//    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
//    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
//    return [identityCardPredicate evaluateWithObject:identityCard];
//}

// 身份证验证
- (BOOL)validateIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length = 0;
    
    if (!value) {
        return NO;
    }
    else {
        length = (int)value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12",@"13",@"14",@"15",@"21",@"22",@"23",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"41",@"42",@"43",@"44",@"45",@"46",@"50",@"51",@"52",@"53",@"54",@"61",@"62",@"63",@"64",@"65",@"71",@"81",@"82",@"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    
    BOOL areaFlag =NO;
    
    for (NSString *areaCode in areasArray) {
        
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    int year =0;
    switch (length) {
        case 15:{
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                int Y = S %11;
                
                NSString *M =@"F";
                
                NSString *JYM =@"10X98765432";
                
                M = [JYM substringWithRange:NSMakeRange(Y,1)];//判断校验位
                
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
            }else {
                
                return NO;
            }
        default:
            return NO;
    }
}

//判断是否银行卡
- (BOOL) checkCardNo:(NSString*) cardNo{
    int oddsum = 0;    //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength -1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1,1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) ==0)
        return YES;
    else
        return NO;
}

//邮箱
- (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//获取网络图片的尺寸
-(CGSize)getImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;                  // url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    return size;
}


//  获取PNG图片的大小
-(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

//  获取gif图片的大小
-(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取jpg图片的大小
-(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}


-(void)dealloc
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
}

+ (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth
{
    if (!image) return nil;
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = newImageWidth;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


//@end
//
//@implementation NSString (ext)
//-(float)getChatRichTextHeight:(int)width   fontSize:(int)font  withLineSpace:(float)lineSpace{
//    RichLabel * label =[[RichLabel alloc] initWithFrame:CGRectZero];
//    label.isConvertLink=NO;
//    [label setMessage:self withWidth:width withFont:font withSpace:lineSpace];
//    float contentHeight =[label getSize:width].height;
//    return contentHeight;
//}
//
//- (float)getChatRichTextWidth :(int)width   fontSize:(int)font  withLineSpace:(float)lineSpace
//{
//    RichLabel * label =[[RichLabel alloc] initWithFrame:CGRectZero];
//    label.isConvertLink=NO;
//    [label setMessage:self withWidth:width withFont:font withSpace:lineSpace];
//    float contentWidth =[label getSize:width].width;
//    return contentWidth;
//}


@end
