//
//  KNPch.h
//  KNPhotoBrower
//
//  Created by LuKane on 16/8/16.
//  Copyright © 2016年 LuKane. All rights reserved.
//

#ifndef ScreenWidth
    #define ScreenWidth [UIScreen mainScreen].bounds.size.width
#endif

#ifndef ScreenHeight
    #define ScreenHeight [UIScreen mainScreen].bounds.size.height
#endif

#define PhotoBrowerBackgroundAlpha 1.f
#define PhotoBrowerBrowerTime      .3f
#define PhotoBrowerMargin          20.f

// 图片的最大放大倍数
#define PhotoBrowerImageMaxScale   2.f
// 图片的最小缩小倍数
#define PhotoBrowerImageMinScale   1.f

#define PhotoSaveImageSuccessMessage  @"^_^ Successfully saved!!"
#define PhotoSaveImageFailureMessage @"/(ㄒoㄒ)/~~ Save failed!!"
#define PhotoSaveImageMessageTime    2
#define PhotoSaveImageFailureReason  @"Image needs to be downloaded"
#define PhotoShowPlaceHolderImageColor [UIColor blackColor]

#import "UIView+PBExtesion.h"
