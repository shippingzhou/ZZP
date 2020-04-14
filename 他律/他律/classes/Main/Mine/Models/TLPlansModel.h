//
//  TLPlansModel.h
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLPlansModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *rate;

@property (nonatomic, copy) NSString *allDay;

@property (nonatomic, copy) NSString *nowDay;

@property (nonatomic, copy) NSString *lastDay;

@property (nonatomic, copy) NSString *lastTime;

@property (nonatomic, copy) NSString *beixuan;

@property (nonatomic, copy) NSString *status;

@end

NS_ASSUME_NONNULL_END
