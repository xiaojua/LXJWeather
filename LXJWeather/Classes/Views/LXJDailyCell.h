//
//  LXJDailyCell.h
//  LXJWeather
//
//  Created by xiaojuan on 17/2/14.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXJDaily.h"

@interface LXJDailyCell : UITableViewCell

@property (nonatomic, strong)LXJDaily *dailyModel;

+ (LXJDailyCell *)getDailyCell;

@end
