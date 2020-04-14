//
//  TLMyGroupCell.h
//  他律
//
//  Created by sineboy on 2019/12/19.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLBaseTableViewCell.h"
#import "TLGroupModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TLMyGroupCell : TLBaseTableViewCell

@property (nonatomic, strong) TLGroupModel *model;

@property (nonatomic, copy) CallBackBlock remindBtnCallBack;

@end

NS_ASSUME_NONNULL_END
