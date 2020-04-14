//
//  TLLoginRootView.h
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLVerifyCodeBtn.h"

NS_ASSUME_NONNULL_BEGIN

@interface TLLoginRootView : UIView

@property (nonatomic, strong) UITextField *accountField; //

@property (nonatomic, strong) UITextField *passwordField; //

@property (nonatomic, strong) UIButton *loginBtn; //

@property (nonatomic, strong) TLVerifyCodeBtn *getCodeBtn;

@end

NS_ASSUME_NONNULL_END
