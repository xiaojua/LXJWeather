//
//  LXJDataManager.m
//  LXJWeather
//
//  Created by xiaojuan on 17/2/9.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import "LXJDataManager.h"
#import "LXJCityGroupModel.h"

@implementation LXJDataManager

static NSArray *_cityGroup = nil;

/* 返回所有城市组的数据(解析plist文件) */
+(NSArray *)getAllCityGroups{
    if (!_cityGroup) {
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"cityGroups.plist" ofType:@""];
        NSArray *cityGroupsArr = [NSArray arrayWithContentsOfFile:plistPath];
        NSMutableArray *mutableArr = [NSMutableArray array];
        for (NSDictionary *dict in cityGroupsArr) {
            LXJCityGroupModel *group = [[LXJCityGroupModel alloc]init];
            [group setValuesForKeysWithDictionary:dict];
            [mutableArr addObject:group];
        }
        _cityGroup = [mutableArr copy];
    }
    return _cityGroup;
}
/* 表格头部当前天气 */
+(LXJCurrentWeatherModel *)getCurrentWeatherData:(id)responseObject{
    NSDictionary *currentWeatherDict = responseObject[@"HeWeather5"][0];
    LXJCurrentWeatherModel *currentWeather = [LXJCurrentWeatherModel new];
    currentWeather.weatherIconUrl = currentWeatherDict[@"now"][@"cond"][@"code"];
    currentWeather.weather = currentWeatherDict[@"now"][@"cond"][@"txt"];
    currentWeather.currentTemp = [currentWeatherDict[@"now"][@"tmp"] stringByAppendingString:@"°C"];
    
    //表格底部部分数据
    currentWeather.windSpeedStr = [currentWeatherDict[@"now"][@"wind"][@"spd"] stringByAppendingString:@"kmph"];
    currentWeather.windDirStr = currentWeatherDict[@"now"][@"wind"][@"dir"];
    currentWeather.feelTempStr = [currentWeatherDict[@"now"][@"fl"] stringByAppendingString:@"°C"];
    currentWeather.precipitationStr = [currentWeatherDict[@"now"][@"pcpn"] stringByAppendingString:@"mm"];
    currentWeather.pressureStr = [currentWeatherDict[@"now"][@"pres"] stringByAppendingString:@"百帕"];
    
    return currentWeather;
}
/* 每天天气天气数组（LXJDaily）(未来七天天气) */
+(NSArray *)getAllDailyData:(id)responseObject{
    NSArray *dailyArr = responseObject[@"HeWeather5"][0][@"daily_forecast"];
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (NSDictionary *dict in dailyArr) {
        LXJDaily *daily = [LXJDaily new];
        NSString *weekStr = [self getWeekStrWithDateStr:dict[@"date"]];
        daily.preDateStr = weekStr;
        daily.iconCodeStr = dict[@"cond"][@"code_d"];
        daily.hiTemp = dict[@"tmp"][@"max"];
        daily.loTemp = dict[@"tmp"][@"min"];
        
        //表格底部部分数据
        daily.sunRiseStr = dict[@"astro"][@"sr"];
        daily.sunSetStr = dict[@"astro"][@"ss"];
        daily.rainPStr = [dict[@"pop"] stringByAppendingString:@"%"];
        daily.humidityPStr = [dict[@"hum"] stringByAppendingString:@"%"];
        
        [mutableArr addObject:daily];
    }
    
    return [mutableArr copy];
}
/* 日期转换成星期几 */
+ (NSString *)getWeekStrWithDateStr:(NSString *)dateStr {
    
    NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init] ;
    [weekFormatter setDateFormat:@"EEEE"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    NSString *weekStr = [weekFormatter stringFromDate:date];
    
    return weekStr;
}
/* 表格底部数据 */
+(LXJLivingIndexModel *)getLifeData:(id)responseObject{
    NSDictionary *lifeDict = responseObject[@"HeWeather5"][0][@"suggestion"];
    LXJLivingIndexModel *life = [LXJLivingIndexModel new];
    
    life.sportStr = lifeDict[@"sport"][@"brf"];
    life.sportDescStr = lifeDict[@"sport"][@"txt"];
    life.ultravioletStr = lifeDict[@"uv"][@"brf"];
    life.ultravioletDescStr = lifeDict[@"uv"][@"txt"];
    
    return life;
}



@end
