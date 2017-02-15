//
//  LXJCurrentWeatherModel.h
//  LXJWeather
//
//  Created by xiaojuan on 17/2/13.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXJCurrentWeatherModel : NSObject

/*
    表格头部视图的当前天气
 */

/* 当前天气图片iconURL */
@property (nonatomic, copy)NSString *weatherIconUrl;
/* 当前天气情况 */
@property (nonatomic, copy)NSString *weather;
/* 当前温度 */
@property (nonatomic, copy)NSString *currentTemp;

/*
    表格脚部视图的当前天气
 */
/* 风速 */
@property (nonatomic, copy)NSString *windSpeedStr;
/* 风向 */
@property (nonatomic, copy)NSString *windDirStr;
/* 体感温度 */
@property (nonatomic, copy)NSString *feelTempStr;
/* 降水量 */
@property (nonatomic, copy)NSString *precipitationStr;
/* 气压 */
@property (nonatomic, copy)NSString *pressureStr;


@end
