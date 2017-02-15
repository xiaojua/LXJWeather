//
//  LXJFooterView.h
//  LXJWeather
//
//  Created by xiaojuan on 17/2/14.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 脚部视图
 */


@interface LXJFooterView : UIView


//7天预报接口里
/* 日出时间label */
@property (nonatomic, strong)UILabel *sunRiseLabel;
/* 日落时间 */
@property (nonatomic, strong)UILabel *sunSetLabel;

/* 降水概率 */
@property (nonatomic, strong)UILabel *rainPLabel;
/* 相对湿度 */
@property (nonatomic, strong)UILabel *humidityPLabel;

//实况接口
/* 风速 */
@property (nonatomic, strong)UILabel *windSpeedLabel;
/* 风向 */
@property (nonatomic, strong)UILabel *windDirLabel;
/* 体感温度 */
@property (nonatomic,strong)UILabel *feelTempLabel;

/* 降水量 */
@property (nonatomic, strong)UILabel *precipitationLabel;
/* 气压 */
@property (nonatomic, strong)UILabel *pressureLabel;


//生活指数接口
/* 运动指数 */
@property (nonatomic, strong)UILabel *sportLabel;
/* 是否适宜运动描述 */
@property (nonatomic, strong)UILabel *sportDescLabel;

/* 紫外线指数 */
@property (nonatomic, strong)UILabel *ultravioletLabel;
/* 紫外线指数描述 */
@property (nonatomic, strong)UILabel *ultravioletDescLabel;




@end
