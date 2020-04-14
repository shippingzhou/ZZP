//
//  TLNewestLvyouQuanCell.h
//  他律
//
//  Created by sineboy on 2019/12/22.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLBaseTableViewCell.h"
#import "TLLvyouQuanModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TLNewestLvyouQuanCell : TLBaseTableViewCell

@property (nonatomic, strong) TLLvyouQuanModel *model;

@property (nonatomic, copy) CallBackBlock personalCallBack;

@property (nonatomic, copy) CallBackBlock titleCallBack;

@property (nonatomic, copy) CallBackBlock contentCallBack;

@property (nonatomic, copy) CallBackBlock bottomBtnCallBack;

@property (nonatomic, copy) CallBackTowBlock picBtnCallBack;

@property (nonatomic, copy) CallBackBlock shenpingCallBack;

@end

NS_ASSUME_NONNULL_END
