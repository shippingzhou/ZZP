//
//  TLSettingCell.h
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLBaseTableViewCell.h"
#import "TLSettingModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TLSettingCell : TLBaseTableViewCell

@property (nonatomic, copy) CallBackBlock switchBtnCallback;

@property (nonatomic, strong) TLSettingModel *model;

@end

NS_ASSUME_NONNULL_END
