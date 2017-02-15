//
//  LXJDaily.h
//  LXJWeather
//
//  Created by xiaojuan on 17/2/14.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
    每天天气情况(未来七天天气情况)，预报日期（要转换成星期几），天气状况图片（白天），最高温，最低温
 */

@interface LXJDaily : NSObject

/* 预报日期str */
@property (nonatomic, copy)NSString *preDateStr;
/* 天气状况图片str */
@property (nonatomic, copy)NSString *iconCodeStr;
/* 预报那天的最高温度 */
@property (nonatomic, copy)NSString *hiTemp;
/* 预报那天的最低温度 */
@property (nonatomic, copy)NSString *loTemp;


/* 
    脚部视图
 */

/* 日出时间 */
@property (nonatomic, copy)NSString *sunRiseStr;
/* 日落时间 */
@property (nonatomic, copy)NSString *sunSetStr;
/* 降水概率 */
@property (nonatomic, copy)NSString *rainPStr;
/* 相对湿度 */
@property (nonatomic, copy)NSString *humidityPStr;



@end
