//
//  LXJDataManager.h
//  LXJWeather
//
//  Created by xiaojuan on 17/2/9.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXJCurrentWeatherModel.h"
#import "LXJDaily.h"
#import "LXJLivingIndexModel.h"

@interface LXJDataManager : NSObject

//本地数据处理
/* 返回所有城市组的数据 */
+ (NSArray *)getAllCityGroups;


//网络数据处理
/* 表格头部当前天气 */
+ (LXJCurrentWeatherModel *)getCurrentWeatherData:(id)responseObject;

/* 每天天气天气数组（LXJDaily）(未来七天天气) */
+ (NSArray *)getAllDailyData:(id)responseObject;

/* 表格底部数据 */
+ (LXJLivingIndexModel *)getLifeData:(id)responseObject;


@end
