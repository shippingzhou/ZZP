//
//  TLPlansContentHeadView.h
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLPlansModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TLPlansContentHeadView : UIView

@property (nonatomic, strong) TLPlansModel *model;

@property (nonatomic, copy) CallBackBlock chakanCallback;

@end

NS_ASSUME_NONNULL_END
