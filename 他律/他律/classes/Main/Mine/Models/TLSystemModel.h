//
//  TLSystemModel.h
//  他律
//
//  Created by sineboy on 2019/12/27.
//  Copyright © 2019 com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLSystemModel : NSObject

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *systemContent;

@property (nonatomic, assign) CGFloat authorLblWidth;

@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, assign) CGFloat systemContentHeight;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGFloat systemCellHeight;

@property (nonatomic, assign) BOOL isOpen;

@end

NS_ASSUME_NONNULL_END
