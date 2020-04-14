//
//  TLSystemNotificationCell.h
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLBaseTableViewCell.h"
#import "TLSystemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TLSystemNotificationCell : TLBaseTableViewCell

@property (nonatomic, strong) TLSystemModel *model;

@property (nonatomic, copy) CallBackBlock chakanCallback;

@end

NS_ASSUME_NONNULL_END
