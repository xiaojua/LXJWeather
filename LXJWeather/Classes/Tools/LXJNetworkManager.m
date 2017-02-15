//
//  LXJNetworkManager.m
//  LXJWeather
//
//  Created by xiaojuan on 17/2/13.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import "LXJNetworkManager.h"

@implementation LXJNetworkManager

+(void)sendRequestWithUrl:(NSString *)urlStr paratemers:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //通过successBlock把服务器返回的responseObject返回调用控制器
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ////通过failureBlock把服务器返回的error返回调用控制器
        failure(error);
    }];
    
    
}

@end
