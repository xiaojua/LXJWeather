//
//  AppDelegate+LXJLocation.m
//  LXJWeather
//
//  Created by xiaojuan on 17/2/9.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

/*
 分类 和 继承的区别: 官方:分类不能够添加属性
 使用runtime来让分类也能够添加属性
 */


#import "AppDelegate+LXJLocation.h"
#import <objc/runtime.h>



@implementation AppDelegate (LXJLocation)

#pragma mark - 重写set，get方法
- (void)setLocationManager:(CLLocationManager *)locationManager{
    //@selector(locationManager) -> 本质就是个指针地址
    //绑定了指针地址和locationManager变量
    return objc_setAssociatedObject(self, @selector(locationManager), locationManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CLLocationManager *)locationManager{
    //_cmd 当前方法的指针
    return objc_getAssociatedObject(self, _cmd);
}
#pragma mark - 初始化CLLocationManager并开始定位设置初始化城市
- (void)setupLocation{
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    /* 程序使用期间允许访问地理数据 */
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    //开启定位服务
    [self.locationManager startUpdatingLocation];
    //异步设置初始城市
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (!kCurrentCity) {
            [[NSUserDefaults standardUserDefaults] setObject:@"北京" forKey:kCurrentCityName];
            [[NSUserDefaults standardUserDefaults] synchronize];
            dispatch_async(dispatch_get_main_queue(), ^{
                //当前城市
                NSString *currentCity = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentCityName];
                //发送城市改变的通知
                [[NSNotificationCenter defaultCenter] postNotificationName:kCurrentCityChangedNotification object:self userInfo:@{kCityChangeKey:currentCity}];
                
            });
        }
    });
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //获取地理位置中的最后一个位置
    CLLocation *location = locations.lastObject;
    if (locations) {
        manager.delegate = nil;
        //关闭定位服务
        [manager stopUpdatingLocation];
        //反地理编码: 经纬度->人类明白的信息
        [[CLGeocoder new] reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            //获取最后一个地标对象
            CLPlacemark *placeMark = placemarks.lastObject;
            MYLog(@"最后一个地标的详细信息：%@", placeMark.addressDictionary);
            NSString *cityChinese = placeMark.locality;
            //获取到的是“北京市“，转换成”北京”
            [cityChinese substringToIndex:cityChinese.length-1];
            //排除掉非联网状态时, 无法反地理编码得到城市名称问题.
            if (![kCurrentCity isEqualToString:cityChinese] && cityChinese != nil) {
                NSString *meg = [NSString stringWithFormat:@"当前城市发生改变，是否要切换到‘%@’？", cityChinese];
                [UIAlertView bk_showAlertViewWithTitle:@"切换城市" message:meg cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    if (buttonIndex == 1) {
                        //保存新的城市名称到UserDefaults
                        [[NSUserDefaults standardUserDefaults] setObject:cityChinese forKey:kCurrentCityName];
                        //命令立刻把内存中的plist存入沙盒
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        //发送城市改变的全局通知
                        [[NSNotificationCenter defaultCenter] postNotificationName:kCurrentCityChangedNotification object:self userInfo:@{kCityChangeKey:cityChinese}];
                    }
                }];
                
            }
            
        }];
        
        
        
    }
}

@end
