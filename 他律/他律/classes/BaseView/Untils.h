//
//  Untils.h
//  LoveU
//
//  Created by 肖亮 on 15/11/10.
//  Copyright © 2015年 肖亮. All rights reserved.
//  工具类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class L_BaseViewController;

typedef void (^UserLatAndLng) (float lat, float lng);
typedef void (^generalApi) (BOOL isSuccess, NSString * resultcode, id dictionary);

@interface Untils : NSObject

+(instancetype)defaultUntils;

@property (nonatomic, assign) float userLat;        //用户经度
@property (nonatomic, assign) float userLng;        //用户维度
@property (nonatomic, copy) UserLatAndLng latAndLng;
@property (nonatomic, copy) generalApi ganeral;



/**
 *  获取经纬度
 *
 *  @param latAndLng 回调block
 */
-(void)gainUserLatAndLng:(UserLatAndLng)latAndLng;

/**
 *  模糊一张图片
 *
 *  @param image 需要模糊的图片
 *
 *  @return 返回一张模糊的图片
 */
-(UIImage *)bandBlurImageWith:(UIImage *)image andGaussBlur:(float)blur andColor:(UIColor *)color;

/**
 *  压缩一张图片（压缩成正方形）
 *
 *  @param image 需要压缩的图片
 *
 *  @return 返回存在沙盒里的地址
 */
-(NSString *)setImagePathFile:(UIImage *)image;

//压缩图片
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

/**
 *  压缩一张图片
 *
 *  @param scale    需要压缩图片的比例
 *  @return 返回存在沙盒里的地址（用于上传）
 */
-(NSString *)setImagePathFile:(UIImage *)image andScale:(float)scale;

/**
 *  获取版本号
 *
 *  @return 返回一个版本号
 */
-(NSString *)gainVersion;

/**
 *  获取build号
 *
 */
-(NSString *)gainBuildNum;

/**
 *  业务功能跳转
 *
 *  @param vc  跳转主VC
 *  @param url 跳转Url
 */
-(void)TheBusinessFunctionJumpsByHomeVC:(L_BaseViewController *)vc andJumpUrl:(NSString *)url;


//判断是否是全空的字符串
- (BOOL)isBlankString :(NSString *)string;

-(NSArray *)gainDataByFileName:(NSString *)name andFormat:(NSString *)format;

/**
 * 基本业务网络请求
 *
 *  @param contentID  内容ID
 *  @param contentType  内容类型 999=分享APP本身 1=长文推荐   2=PUA课堂  3=大家都在聊
 *  @param type  请求类型   1:收藏   2:删除收藏   3:点赞接口  4:取消点赞接口 5:分享完成上报
 *  @param block 返回请求结果
 */
-(void)POSTgeneralAPIByID:(NSString *)contentID andContentTYpe:(NSString *)contentType andFunctionType:(NSString *)type andsuccessblock:(generalApi)block;

//创建一个转场动画
-(void)createVCChangeAnimation:(UIWindow *)window andVC:(UIViewController *)vc;

/**
 *  将服务器时间戳转化成显示时间
 *  发帖页面、我的求助页面、我的动态页面、我的收藏页面、长文页面、聊天对话页面，在线课程等页面
 *  @param clientTime 服务器时间戳
 *  @return 转化后的时间
 **/
-(NSString *)handleShowTimeStringByClientTime:(NSString *)clientTime;

//获取时间
- (NSString *)updateTimeForRow:(NSString *)clientTime;

//显示服务器时间
-(NSString *)showCurrentTimeStringByClientTime:(NSString *)clientTime;

#pragma mark - 截取一张以图片中心的正方形图片的地址
-(UIImage *)cutCenterImage:(UIImage *)image size:(CGSize)size;

//剪切图片
-(UIImage*)image:(UIImage*)image  fortargetSize: (CGSize)targetSize;
//转化时间
- (NSString *)getCurrentTimeFromClientTime:(NSString *)clientTime;
//时间戳转化成日期
-(NSString *)showTimeStringByClientTime:(NSString *)clientTime;

//计算带emoji表情文字高度
- (CGFloat)heightWithEmojiText:(NSString *)text font:(UIFont *)font constrainedToWidth:(CGFloat)width;

//计算文字高度
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width andHeight:(float)height isBoldMT:(BOOL)isBoldMT;

//计算文字宽度
-(float) widthForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width andHeight:(float)height isBoldMT:(BOOL)isBoldMT;

/**
 *  订单时间显示
 *
 *  @param clientTime 服务器时间戳
 *  @return 转化后的时间
 **/
-(NSString *)handleOrderShowTimeStringByClientTime:(NSString *)clientTime;

/**
 *  活动时间显示
 *  @param clientTime 服务器时间戳
 *  @return 转化后的时间
 */
-(NSString *)handleActivitiShowTimeStringByClientTime:(NSString *)clientTime;

/**
 *  创建距离多少年前的date
 *  @param laterInt (要获取18年前的就输入18)
 *  @return 返回一个NSDate对象
 */
-(NSDate *)createDateByLaterTimeInt:(int)laterInt;

//根据需要宽度压缩图片
+ (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth;


//验证名字
- (BOOL) validateUserName:(NSString *)name;

//判断是否包含emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string;

//空格判断
-(BOOL)isEmpty:(NSString *) str;

//手机号码验证
- (BOOL) validateMobile:(NSString *)mobile;

// 身份证验证
- (BOOL)validateIDCardNumber:(NSString *)value;

//判断是否银行卡
- (BOOL) checkCardNo:(NSString*) cardNo;

//判断邮箱
- (BOOL) validateEmail:(NSString *)email;

//获取网络图片的尺寸
-(CGSize)getImageSizeWithURL:(id)imageURL;

/******************************************************************************
 函数名称 : + (NSData *)dataWithBase64EncodedString:(NSString *)string
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 :
 ******************************************************************************/
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;

/******************************************************************************
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data;

@end

@interface NSString (ext)

-(float)getChatRichTextHeight:(int)width   fontSize:(int)font  withLineSpace:(float)lineSpace;
-(float)getChatRichTextWidth :(int)width   fontSize:(int)font  withLineSpace:(float)lineSpace;

@end
