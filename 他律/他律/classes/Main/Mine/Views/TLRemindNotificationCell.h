//
//  TLRemindNotificationCell.h
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLBaseTableViewCell.h"
#import "TLNotificationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TLRemindNotificationCell : TLBaseTableViewCell

@property (nonatomic, strong) TLNotificationModel *model;

@end

NS_ASSUME_NONNULL_END
