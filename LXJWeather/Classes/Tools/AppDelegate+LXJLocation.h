//
//  AppDelegate+LXJLocation.h
//  LXJWeather
//
//  Created by xiaojuan on 17/2/9.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import "AppDelegate.h"

/* @import Xcode7之后的新特性, 好处就是不需要到Build Phaze里面去引入类库了 */
@import CoreLocation;


@interface AppDelegate (LXJLocation)<CLLocationManagerDelegate>

@property (nonatomic, strong)CLLocationManager *locationManager;

- (void)setupLocation;

@end
