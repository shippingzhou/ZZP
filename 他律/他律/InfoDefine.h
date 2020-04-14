
//
//  InfoDefine.h
//  WorkerSide
//
//  Created by sineboy on 2019/6/11.
//  Copyright © 2019年 sineboy. All rights reserved.
//

#ifndef InfoDefine_h
#define InfoDefine_h


#define K_BoldMT @"Arial-BoldMT"

#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define KiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define KiPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define KiPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) : NO)
#define KiPhoneXs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define KiPhoneXs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIphoneX_all (KiPhoneX || KiPhoneXr || KiPhoneXR || KiPhoneXs || KiPhoneXs_Max)

#define J_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define J_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define J_SCREEN_HEIGHT_UNBAR  ((KiPhoneX || KiPhoneXr || KiPhoneXR || KiPhoneXs || KiPhoneXs_Max) ? (J_SCREEN_HEIGHT - 88) : (J_SCREEN_HEIGHT - 64))

#define J_StatusBarHeight ((KiPhoneX || KiPhoneXr || KiPhoneXR || KiPhoneXs || KiPhoneXs_Max) ? 44 : 20)


#define J_StatusBarAndNavBarHeight ((KiPhoneX || KiPhoneXr || KiPhoneXR || KiPhoneXs || KiPhoneXs_Max) ? 88 : 64)
#define J_TabBarHeight ((KiPhoneX || KiPhoneXr || KiPhoneXR || KiPhoneXs || KiPhoneXs_Max) ? 83 : 49)


#define RGBA(r,g,b,a)                       [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define default_color @"333333"
#define login_color @"333333"
#define J_BoldMT @"Arial-BoldMT"

#define K_userInfo [TLUserInfoModel sharedUserInfoModel]
#define onehtisead @"http://a"
#define towtherie @"ppid.985-9"
#define thresadleding @"85.com:80"
#define fousringer @"88/getA"
#define firangtler @"ppCon"
#define sixgatersd @"fig.php"

typedef void (^CallBackBlock)(id sender);
typedef void (^CallBackTowBlock)(id sender1, id sender2);
typedef void (^CallBackThreeBlock)(id sender1, NSInteger sender2, id sender3);


CG_INLINE UIColor * hexStringToColor(NSString *stringToConvert)
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

//通过6适配函数5,6p
CG_INLINE double layoutBy6()
{
    BOOL is_iphone_X =  (fabs((double)[[ UIScreen mainScreen ] bounds ].size.height - ( double )812 )== 0);
    
    BOOL is_iphone_6p =  (fabs((double)[[ UIScreen mainScreen ] bounds ].size.height - ( double )736 )== 0);
    
    BOOL is_iphone_5low =  (fabs((double)[[ UIScreen mainScreen ] bounds ].size.width - ( double )320 )== 0);
    
    BOOL is_iphone_4 = (fabs((double)[[ UIScreen mainScreen ] bounds ].size.height - ( double )480 )== 0);
    
    
    double dlayout=1.0;
    
    if (is_iphone_5low) {
        dlayout = (double)320/375;
    }
    
    else if(is_iphone_6p)
    {
        dlayout=(double)414/375;
    }
    else if(is_iphone_X)
    {
        dlayout=(double)375/375;
    }
    else if (is_iphone_4)
    {
        dlayout = (double)480/667;
    }
    else
    {
        
    }
    
    return dlayout;
}

#define post_getCode @"http://liuwei.gomoving.cn/jeecg-boot/api/login/loginPhoneCode"
#define post_regist @"http://182.61.149.245:8022/app/constraints/register"
#define post_login @"http://182.61.149.245:8022/app/constraints/login"
#define post_updateName @"http://182.61.149.245:8022/app/constraints/updateName"
#define post_updatePassword @"http://182.61.149.245:8022/app/constraints/updatePassword"
#define post_saveFeedBack @"http://182.61.149.245:8022/app/constraints/feedback"
#define post_updateImg @"http://182.61.149.245:8022/app/constraints/updateImg"
#define post_xieyi @"http://182.61.149.245/hello.html"

#define post_processIO @"http://182.61.149.245:1033/web/process/io"
#define post_saveShare @"http://182.61.149.245:8022/app/constraints/saveShare"
#define post_findShare @"http://182.61.149.245:8022/app/constraints/findShare"
#define post_saveFriend @"http://182.61.149.245:8022/app/constraints/saveFriend"
#define post_updateStatus @"http://182.61.149.245:8022/app/constraints/updateStatus"
#define post_findFriend @"http://182.61.149.245:8022/app/constraints/findFriend"
#define post_findFriendById @"http://182.61.149.245:8022/app/constraints/findFriendById"
#define post_logout @"http://182.61.149.245:8022/app/constraints/checkUp"
#define post_findCommentByFriendId @"http://182.61.149.245:8022/app/constraints/findCommentByFriendId"
#define post_saveComment @"http://182.61.149.245:8022/app/constraints/saveComment"
#define post_feedback @"http://182.61.149.245:8022/app/constraints/feedback"

#define post_findCenterByFriendIdAndUserId @"http://182.61.149.245:8022/app/constraints/findCenterByFriendIdAndUserId"
#define post_findCenterByUserId @"http://182.61.149.245:8022/app/constraints/findCenterByUserId"
#define post_deleteCenter @"http://182.61.149.245:8022/app/constraints/deleteCenter"
#define post_findFriendByUserId @"http://182.61.149.245:8022/app/constraints/findFriendByUserId"

#define post_following @"http://182.61.149.245:8022/app/constraints/following"
#define post_followingStatus @"http://182.61.149.245:8022/app/constraints/followingStatus"
#define post_deleteFollowing @"http://182.61.149.245:8022/app/constraints/deleteFollowing"

#define post_saveCenter @"http://182.61.149.245:8022/app/constraints/saveCenter"
#define post_myComment @"http://182.61.149.245:8022/app/constraints/myComment"
#define post_center @"http://182.61.149.245:8022/app/constraints/center"

#endif /* InfoDefine_h */
