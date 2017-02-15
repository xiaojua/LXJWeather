//
//  LXJCityGroupModel.h
//  LXJWeather
//
//  Created by xiaojuan on 17/2/9.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXJCityGroupModel : NSObject

/* 城市组名称 */
@property (nonatomic, copy)NSString *title;
/* 城市组中城市列表（数组） */
@property (nonatomic, strong)NSArray *cities;


@end
