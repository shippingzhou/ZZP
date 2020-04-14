//
//  TLUserInfoModel.m
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLUserInfoModel.h"

@implementation TLUserInfoModel

static dispatch_once_t LoginToken;

+ (instancetype)sharedUserInfoModel {
    static TLUserInfoModel *instance;
    dispatch_once(&LoginToken, ^{
        
        YYCache *cache = [YYCache cacheWithName:@"ul"];
        id obj = [cache objectForKey:@"UserInfo"];
        
        if (obj == nil) {
            instance = [[self alloc] init];
            
        } else {
            instance = obj;
        }
    });
    return instance;
}


+ (void)saveUserAccountToDiskCache {
    YYCache *cache = [YYCache cacheWithName:@"ul"];
    [cache setObject:[TLUserInfoModel sharedUserInfoModel] forKey:@"UserInfo"];
}

+ (void)clear {
    YYCache *cache = [YYCache cacheWithName:@"ul"];
    [cache setObject:[TLUserInfoModel new] forKey:@"UserInfo"];
    LoginToken = 0;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        if (aDecoder == nil) {
            return self;
        }
        self.id = [aDecoder decodeObjectForKey:@"user_id"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.id forKey:@"user_id"];
}

@end
