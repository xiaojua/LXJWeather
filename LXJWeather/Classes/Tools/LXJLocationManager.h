//
//  LXJLocationManager.h
//  LXJWeather
//
//  Created by xiaojuan on 17/2/10.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;

@interface LXJLocationManager : NSObject

+ (void)getUserLocation:(void(^)(double latitude, double longitude))locationBlock;

@end
