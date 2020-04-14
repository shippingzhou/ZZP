//
//  TLBaseTableView.m
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLBaseTableView.h"

@implementation TLBaseTableView

-(instancetype)init {
    if (self == [super init]) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if ([super initWithFrame:frame style:style]) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

@end
