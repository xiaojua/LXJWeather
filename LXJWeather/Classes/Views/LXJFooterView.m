//
//  LXJFooterView.m
//  LXJWeather
//
//  Created by xiaojuan on 17/2/14.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import "LXJFooterView.h"
#import "UILabel+LXJLabel.h"

/* 常量 */
/* 垂直间距 */
const CGFloat insertV = 15;
/* 水平间距 */
const CGFloat insertH = 10;
/* 普通label高 */
#define labelH (SCREEN_H-insertV*7)/15
/* 运动指数描述和紫外线指数描述label高 */
#define labelHH ((SCREEN_H-insertV*7)/15)*2
/* label宽 */
#define labelW (SCREEN_W-insertH*3)/2
/* label中字体大小 */
const CGFloat fontSize = 17;

@implementation LXJFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        /* 日出时间label */
        UILabel *sunR = [UILabel labelWithFrame:CGRectMake(insertH, insertV, labelW, labelH)];
        sunR.textAlignment = NSTextAlignmentRight;
        sunR.text = @"日出：";
        sunR.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:sunR];
        self.sunRiseLabel = [UILabel labelWithFrame:CGRectMake(insertH*2+labelW, insertV, labelW, labelH)];
        self.sunRiseLabel.text = @"05:41";
        self.sunRiseLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:self.sunRiseLabel];
        /* 日落时间 */
        UILabel *sunS = [UILabel labelWithFrame:CGRectMake(insertH, insertV+labelH, labelW, labelH)];
        sunS.text = @"日落：";
        sunS.textAlignment = NSTextAlignmentRight;
        sunS.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:sunS];
        self.sunSetLabel = [UILabel labelWithFrame:CGRectMake(insertH*2+labelW, insertV+labelH, labelW, labelH)];
        self.sunSetLabel.text = @"18:47";
        self.sunSetLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:self.sunSetLabel];
        /* 降水概率 */
        UILabel *rainP = [UILabel labelWithFrame:CGRectMake(insertH, insertV*2+labelH*2, labelW, labelH)];
        rainP.text = @"降水概率：";
        rainP.textAlignment = NSTextAlignmentRight;
        rainP.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:rainP];
        self.rainPLabel = [UILabel labelWithFrame:CGRectMake(insertH*2+labelW, insertV*2+labelH*2, labelW, labelH)];
        self.rainPLabel.text = @"1%";
        self.rainPLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:self.rainPLabel];
        /* 相对湿度 */
        UILabel *hum = [UILabel labelWithFrame:CGRectMake(insertH, insertV*2+labelH*3, labelW, labelH)];
        hum.text = @"湿度：";
        hum.textAlignment = NSTextAlignmentRight;
        hum.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:hum];
        
        self.humidityPLabel = [UILabel labelWithFrame:CGRectMake(insertH*2+labelW, insertV*2+labelH*3, labelW, labelH)];
        self.humidityPLabel.text = @"17%";
        self.humidityPLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:self.humidityPLabel];
        
        /* 风速 */
        UILabel *windS = [UILabel labelWithFrame:CGRectMake(insertH, insertV*3+labelH*4, labelW, labelH)];
        windS.textAlignment = NSTextAlignmentRight;
        windS.text = @"风速：";
        windS.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:windS];
        
        self.windSpeedLabel = [UILabel labelWithFrame:CGRectMake(insertH*2+labelW, insertV*3+labelH*4, labelW, labelH)];
        self.windSpeedLabel.text = @"24kmph";
        self.windSpeedLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:self.windSpeedLabel];
        
        /* 风向 */
        UILabel *windD = [UILabel labelWithFrame:CGRectMake(insertH, insertV*3+labelH*5, labelW, labelH)];
        windD.text = @"风向：";
        windD.textAlignment = NSTextAlignmentRight;
        windD.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:windD];
        
        self.windDirLabel = [UILabel labelWithFrame:CGRectMake(insertH*2+labelW, insertV*3+labelH*5, labelW, labelH)];
        self.windDirLabel.text = @"东北风";
        self.windDirLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:self.windDirLabel];
        
        /* 体感温度 */
        UILabel *feelT = [UILabel labelWithFrame:CGRectMake(insertH, insertV*3+labelH*6, labelW, labelH)];
        feelT.text = @"体感温度：";
        feelT.textAlignment = NSTextAlignmentRight;
        feelT.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:feelT];
        
        self.feelTempLabel = [UILabel labelWithFrame:CGRectMake(insertH*2+labelW, insertV*3+labelH*6, labelW, labelH)];
        self.feelTempLabel.text = @"11°C";
        self.feelTempLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:self.feelTempLabel];
        
        /* 降水量 */
        UILabel *precipitation = [UILabel labelWithFrame:CGRectMake(insertH, insertV*4+labelH*7, labelW, labelH)];
        precipitation.text = @"降水量：";
        precipitation.textAlignment = NSTextAlignmentRight;
        precipitation.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:precipitation];
        
        self.precipitationLabel = [UILabel labelWithFrame:CGRectMake(insertH*2+labelW, insertV*4+labelH*7, labelW, labelH)];
        self.precipitationLabel.text = @"0mm";
        self.precipitationLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:self.precipitationLabel];
        
        /* 气压 */
        UILabel *pressure = [UILabel labelWithFrame:CGRectMake(insertH, insertV*4+labelH*8, labelW, labelH)];
        pressure.text = @"气压：";
        pressure.textAlignment = NSTextAlignmentRight;
        pressure.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:pressure];
        
        self.pressureLabel = [UILabel labelWithFrame:CGRectMake(insertH*2+labelW, insertV*4+labelH*8, labelW, labelH)];
        self.pressureLabel.text = @"1025";
        self.pressureLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:self.pressureLabel];
        
        /* 运动指数 */
        UILabel *sport = [UILabel labelWithFrame:CGRectMake(insertH, insertV*5+labelH*9, labelW, labelH)];
        sport.text = @"运动指数：";
        sport.textAlignment = NSTextAlignmentRight;
        sport.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:sport];
        
        self.sportLabel = [UILabel labelWithFrame:CGRectMake(insertH*2+labelW, insertV*5+labelH*9, labelW, labelH)];
        self.sportLabel.text = @"较适宜";
        self.sportLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:self.sportLabel];
        
        /* 是否适宜运动描述 */
        UILabel *sportD = [UILabel labelWithFrame:CGRectMake(insertH, insertV*5+labelH*10, labelW, labelH)];
        sportD.text = @"运动指数描述：";
        sportD.textAlignment = NSTextAlignmentRight;
        sportD.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:sportD];
        
        self.sportDescLabel = [UILabel labelWithFrame:CGRectMake(insertH*2+labelW, insertV*5+labelH*10, labelW, labelH*2)];
        self.sportDescLabel.text = @"天气较好，户外运动请注意防晒。推荐您进行室内运动。";
        self.sportDescLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize-2];
        self.sportDescLabel.numberOfLines = 0;
        [self addSubview:self.sportDescLabel];
        
        /* 紫外线指数 */
        UILabel *ultraviolet = [UILabel labelWithFrame:CGRectMake(insertH, insertV*6+labelH*12, labelW, labelH)];
        ultraviolet.text = @"紫外线指数：";
        ultraviolet.textAlignment = NSTextAlignmentRight;
        ultraviolet.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:ultraviolet];
        
        self.ultravioletLabel = [UILabel labelWithFrame:CGRectMake(insertH*2+labelW, insertV*6+labelH*12, labelW, labelH)];
        self.ultravioletLabel.text = @"中等";
        self.ultravioletLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:self.ultravioletLabel];
        /* 紫外线指数描述 */
        UILabel *ultravioletD = [UILabel labelWithFrame:CGRectMake(insertH, insertV*6+labelH*13, labelW, labelH)];
        ultravioletD.text = @"紫外线指数描述：";
        ultravioletD.textAlignment = NSTextAlignmentRight;
        ultravioletD.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        [self addSubview:ultravioletD];
        
        self.ultravioletDescLabel = [UILabel labelWithFrame:CGRectMake(insertH*2+labelW, insertV*6+labelH*13, labelW, labelH*2)];
        self.ultravioletDescLabel.text = @"属中等强度紫外线辐射天气，外出时建议涂擦SPF高于15、PA+的防晒护肤品，戴帽子、太阳镜。";
        self.ultravioletDescLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize-2];
        self.ultravioletDescLabel.numberOfLines = 0;
        [self addSubview:self.ultravioletDescLabel];
        
    }
    return self;
}


@end
