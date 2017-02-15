//
//  LXJLivingIndexModel.h
//  LXJWeather
//
//  Created by xiaojuan on 17/2/15.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 生活指数，表格底部视图部分数据
 */


@interface LXJLivingIndexModel : NSObject


/* 运动指数 */
@property (nonatomic, copy)NSString *sportStr;
/* 是否适宜运动描述 */
@property (nonatomic, copy)NSString *sportDescStr;
/* 紫外线指数 */
@property (nonatomic, copy)NSString *ultravioletStr;
/* 紫外线指数描述 */
@property (nonatomic, copy)NSString *ultravioletDescStr;







@end
