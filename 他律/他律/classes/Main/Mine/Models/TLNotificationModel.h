//
//  TLNotificationModel.h
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLNotificationModel : NSObject

@property (nonatomic, copy) NSString *authorImg;

@property (nonatomic, copy) NSString *authorName;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, assign) CGFloat authorLblWidth;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, assign) CGFloat commentHeight;

@property (nonatomic, assign) CGFloat bgViewHeight1;

@property (nonatomic, assign) CGFloat bgViewHeight2;

@end

NS_ASSUME_NONNULL_END
