//
//  TLWechatLoginRootView.h
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLWechatLoginRootView : UIView

@property (nonatomic, strong) UIButton *loginBtn; //

@property (nonatomic, strong) UIButton *moreLoginBtn; //

@property (nonatomic, copy) CallBackBlock xieyiCallback;

@property (nonatomic, strong) UIButton *fuwuxieyiBtn;

@property (nonatomic, strong) UIButton *yisishengmingBtn;

@end

NS_ASSUME_NONNULL_END
