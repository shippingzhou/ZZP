//
//  TLLvyouQuanModel.h
//  他律
//
//  Created by sineboy on 2019/12/22.
//  Copyright © 2019 com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLLvyouQuanModel : NSObject

@property (nonatomic, copy) NSString *authorImg;

@property (nonatomic, copy) NSString *authorName;

@property (nonatomic, copy) NSString *iconImg;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *days;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *imgs;

@property (nonatomic, copy) NSString *isRead;

@property (nonatomic, copy) NSString *isComment;

@property (nonatomic, copy) NSString *isCollect;

@property (nonatomic, copy) NSString *isForward;

@property (nonatomic, copy) NSString *isGuanfang;

@property (nonatomic, copy) NSString *readCount;

@property (nonatomic, copy) NSString *commentCount;

@property (nonatomic, copy) NSString *collectCount;

@property (nonatomic, copy) NSString *forwardCount;

@property (nonatomic, copy) NSString *shenpingAuthor;

@property (nonatomic, copy) NSString *shenpingContent;

@property (nonatomic, copy) NSString *isShenping;

@property (nonatomic, assign) CGFloat authorLblWidth;

@property (nonatomic, assign) CGFloat titleHeight;

@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, assign) CGFloat picViewHeight;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGFloat shenpingHeight;

@end

NS_ASSUME_NONNULL_END
