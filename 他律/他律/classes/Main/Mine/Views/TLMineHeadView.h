//
//  TLMineHeadView.h
//  他律
//
//  Created by sineboy on 2019/12/24.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLMineHeadView : UIView

@property (nonatomic, strong) UILabel *likeCount;

@property (nonatomic, strong) UILabel *commentCount;

@property (nonatomic, strong) UILabel *dayCount;

@property (nonatomic, copy) CallBackBlock personalEditCallback;

@property (nonatomic, copy) CallBackBlock emailEditCallback;

@property (nonatomic, copy) CallBackBlock settingEditCallback;

@property (nonatomic, copy) CallBackBlock likeEditCallback;

@property (nonatomic, copy) CallBackBlock commentEditCallback;

@property (nonatomic, copy) CallBackBlock dayEditCallback;

@end

NS_ASSUME_NONNULL_END
