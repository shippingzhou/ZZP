//
//  TLUserInfoModel.h
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLUserInfoModel : NSObject

@property (nonatomic, copy) NSString *account; //

@property (nonatomic, copy) NSString *userId; //

@property (nonatomic, copy) NSString *id; //用户id

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *signature;

@property (nonatomic, copy) NSString *headImg;

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, assign) CGFloat allFenshu;

+ (instancetype)sharedUserInfoModel;

+ (void)saveUserAccountToDiskCache;

+ (void)clear;

@end

NS_ASSUME_NONNULL_END
