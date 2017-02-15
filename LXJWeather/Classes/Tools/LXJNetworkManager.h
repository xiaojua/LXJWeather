//
//  LXJNetworkManager.h
//  LXJWeather
//
//  Created by xiaojuan on 17/2/13.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  根据指定的数据，封装了发送请求的过程
 *  这个实现请求的过程，可以使用AFN这个第三方
 *  也可以使用系统的NSRULSessionManager
 */


@interface LXJNetworkManager : NSObject

/**
 *  发送get请求
 *
 *  @param urlStr     网络请求的URL
 *  @param params  传一个字典
 *  @param success 请求成功的block
 *  @param failure 请求失败的block
 */

+ (void)sendRequestWithUrl:(NSString *)urlStr paratemers:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end
