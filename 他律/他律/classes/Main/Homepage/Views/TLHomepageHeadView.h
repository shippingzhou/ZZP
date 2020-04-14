//
//  TLHomepageHeadView.h
//  他律
//
//  Created by sineboy on 2019/12/18.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLHomepageHeadView : UIView

@property (nonatomic, strong) NSArray *bannerArr; //装着bannerModel的数组

@property (nonatomic, strong) UIScrollView *bannerScrollView;//图片轮播

@property (nonatomic, copy) CallBackBlock cycleScrollCallBack;//

//加载banner
-(void)addBannerToScrollView;

@end

NS_ASSUME_NONNULL_END
