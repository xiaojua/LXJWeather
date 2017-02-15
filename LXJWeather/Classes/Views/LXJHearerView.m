//
//  LXJHearerView.m
//  LXJWeather
//
//  Created by xiaojuan on 17/2/7.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import "LXJHearerView.h"
#import "UILabel+LXJLabel.h"

/* 常量 */
/* 左右边距 */
const CGFloat insert = 20;
/* 通用label高度 */
const CGFloat labelH = 40;
/* 当前温度label高度 */
const CGFloat temLabelH = 110;

@implementation LXJHearerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        /* 左侧按钮 */
        self.menuButton = [[UIButton alloc]init];
        [self.menuButton setImage:[UIImage imageNamed:@"IconHome"] forState:UIControlStateNormal];
        self.menuButton.frame = CGRectMake(5, 25, 40, 40);
        [self addSubview:self.menuButton];
        /* 城市标签 */
        self.cityLabel = [UILabel labelWithFrame:CGRectMake(0, 25, SCREEN_W, 40)];
        self.cityLabel.textAlignment = NSTextAlignmentCenter;
        self.cityLabel.text = @"加载中...";
        [self addSubview:self.cityLabel];
        /* 天气图片 */
        self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(insert, SCREEN_H-labelH*2-temLabelH, 40, labelH)];
        self.iconView.image = [UIImage imageNamed:@"wsymbol_0001_sunny"];
        [self addSubview:self.iconView];
        /* 当前天气label */
        self.weatherLabel = [UILabel labelWithFrame:CGRectMake(insert+60, SCREEN_H-labelH*2-temLabelH, SCREEN_W-insert*2-40, labelH)];
        self.weatherLabel.text = @"大雪";
        [self addSubview:self.weatherLabel];
        /* 当前温度label */
        self.temLabel = [UILabel labelWithFrame:CGRectMake(insert, SCREEN_H-labelH-temLabelH, SCREEN_W-insert*2, temLabelH)];
        self.temLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:55];
        self.temLabel.text = @"1°C";
        [self addSubview:self.temLabel];
        /* 高低温度label */
        self.hiloLabel = [UILabel labelWithFrame:CGRectMake(insert, SCREEN_H-labelH, SCREEN_W-insert*2, labelH)];
        self.hiloLabel.text = @"-1°C/6°C";
        [self addSubview:self.hiloLabel];
        
    }
    return self;
}







@end
