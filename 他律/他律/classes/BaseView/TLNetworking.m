//
//  TLNetworking.m
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLNetworking.h"

@implementation TLNetworking


+ (NSURLSessionDataTask *)getRequestWithURL:(NSString *)url
                                 parameters:(NSDictionary *)parameters
                                   Progress:(void (^)(CGFloat progress))Progressblock
                                    success:(void(^)(id responseObject))success
                                    failure:(void(^)(NSError *error))failure
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    NSURLSessionDataTask * task = [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败：-> %@",error);
        failure(error);
    }];
    
    return task;
}

+ (NSURLSessionDataTask *)postRequestWithURL:(NSString *)url
                                  parameters:(NSDictionary *)parameters
                                    Progress:(void (^)(CGFloat progress))Progressblock
                                     success:(void(^)(id responseObject))success
                                     failure:(void(^)(NSError *error))failure
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     
 
//    //添加安全策略，及允许无效证书访问
//    AFSecurityPolicy *security = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    [security setValidatesDomainName:NO];
//    security.allowInvalidCertificates = YES;
//    manager.securityPolicy = security;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    NSURLSessionDataTask * task = [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        
    }];
    
    
    
    return task;
}

+ (NSURLSessionDataTask *)newPostRequestWithURL:(NSString *)url
parameters:(id)parameters
  Progress:(void (^)(CGFloat progress))Progressblock
   success:(void(^)(id responseObject))success
                                     failure:(void(^)(NSError *error))failure {

   AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
   // [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
   
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
    NSURLSessionDataTask * task = [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        
    }];


    return task;

}



@end
