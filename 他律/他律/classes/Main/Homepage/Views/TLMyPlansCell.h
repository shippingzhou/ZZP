//
//  TLMyPlansCell.h
//  他律
//
//  Created by sineboy on 2019/12/19.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLBaseTableViewCell.h"
#import "TLMyPlanModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TLMyPlansCell : TLBaseTableViewCell

@property (nonatomic, strong) TLMyPlanModel *model;

@property (nonatomic, copy) CallBackBlock fabuBtnCallBack;

@end

NS_ASSUME_NONNULL_END
