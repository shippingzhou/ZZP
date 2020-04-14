//
//  TLTipsAlertView.h
//  他律
//
//  Created by sineboy on 2020/4/1.
//  Copyright © 2020 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLTipsAlertView : UIView

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, copy) CallBackBlock cancelBtnCallback;

@property (nonatomic, copy) CallBackBlock confirmBtnCallback;

@end

NS_ASSUME_NONNULL_END
