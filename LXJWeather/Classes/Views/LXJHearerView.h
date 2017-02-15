//
//  LXJHearerView.h
//  LXJWeather
//
//  Created by xiaojuan on 17/2/7.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXJHearerView : UIView

/* 左侧主按钮 */
@property (nonatomic, strong)UIButton *menuButton;
/* 城市标签 */
@property (nonatomic, strong)UILabel *cityLabel;
/* 天气图片*/
@property (nonatomic, strong)UIImageView *iconView;
/* 当前天气label */
@property (nonatomic, strong)UILabel *weatherLabel;
/* 当前温度label */
@property (nonatomic, strong)UILabel *temLabel;
/* 高低温度label */
@property (nonatomic, strong)UILabel *hiloLabel;







@end
