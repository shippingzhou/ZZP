//
//  TLNetworking.h
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLNetworking : NSObject

+ (NSURLSessionDataTask *)getRequestWithURL:(NSString *)url
                                 parameters:(NSDictionary *)parameters
                                   Progress:(void (^)(CGFloat progress))Progressblock
                                    success:(void(^)(id responseObject))success
                                    failure:(void(^)(NSError *error))failure;

+ (NSURLSessionDataTask *)postRequestWithURL:(NSString *)url
                                  parameters:(NSDictionary *)parameters
                                    Progress:(void (^)(CGFloat progress))Progressblock
                                     success:(void(^)(id responseObject))success
                                     failure:(void(^)(NSError *error))failure;

+ (NSURLSessionDataTask *)newPostRequestWithURL:(NSString *)url
parameters:(id)parameters
  Progress:(void (^)(CGFloat progress))Progressblock
   success:(void(^)(id responseObject))success
                                        failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
