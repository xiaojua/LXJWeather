//
//  LXJLocationManager.m
//  LXJWeather
//
//  Created by xiaojuan on 17/2/10.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import "LXJLocationManager.h"

@interface LXJLocationManager ()<CLLocationManagerDelegate>

/* 声明一个定位CLLocationManager对象，用单例模式 */
@property (nonatomic, strong)CLLocationManager *locationManager;
/* 声明一个block用于存储用户的地理位置 */
@property (nonatomic, copy) void(^saveLocation)(double latitude, double longitude);


@end

@implementation LXJLocationManager

//懒加载的方式初始化
//单例: 一个类的唯一一个实例对象
+ (instancetype)sharedLoationManager{
    static LXJLocationManager *locationManager = nil;
    if (!locationManager) {
        locationManager = [[LXJLocationManager alloc]init];
    }
    return locationManager;
}
//重写init方法初始化locationManager对象/征求用户同意
- (instancetype)init
{
    if (self = [super init]) {
        //创建/初始化CLLocationManager对象
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        //征求用户的同意(>=iOS8.0需要征求用户同意，否则不需要)
        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
            [self.locationManager requestWhenInUseAuthorization];
        }else{
            [self.locationManager startUpdatingLocation];
        }
    }
    return self;
}
+ (void)getUserLocation:(void (^)(double, double))locationBlock{
    //类方法可以调用自己的实例方法，在实例方法中可以用self，类方法中不可以用self
    //执行上面的逻辑
    LXJLocationManager *manager = [self sharedLoationManager];
    [manager getUserLocation:locationBlock];
}
- (void)getUserLocation:(void(^)(double, double))locationBlock{
    //用户没有同意获取定位
    if (![CLLocationManager locationServicesEnabled]) {
        //告诉用户去设置中的隐私开启服务
        return;
    }
    //!!!将saveLocationBlock赋值给locationBlock
    //copy函数指针/函数体
    _saveLocation = locationBlock;
    //设定精度(调用频率)
    self.locationManager.distanceFilter = 500;//米
    //用户已同意，开启定位
    [self.locationManager startUpdatingLocation];
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //已经获取用户的位置
    CLLocation *userLocation = [locations lastObject];
    //把获取到的地理位置的纬度和经度赋值给block
    _saveLocation(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    //设置locationManager为空，只需要
    self.locationManager = nil;
    if (userLocation) {
        self.locationManager.delegate = nil;
        [self.locationManager stopUpdatingLocation];
        [[CLGeocoder new] reverseGeocodeLocation:userLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            //获取最后一个地标对象
            CLPlacemark *placeMark = placemarks.lastObject;
            //获取当前城市的汉语（前提是手机设置语言为汉语，“北京市”）
            NSString *cityChinese = placeMark.locality;
            //北京市->北京
            cityChinese = [cityChinese substringToIndex:(cityChinese.length-1)];
            //MYLog(@"locationManager中转换后的城市：%@", cityChinese);
            //排除掉非联网状态时, 无法反地理编码得到城市名称问题.
            if (![kCurrentCity isEqualToString:cityChinese] && cityChinese != nil) {
                NSString *msg = [NSString stringWithFormat:@"当前城市发生变化，是否要切换到'%@'?", cityChinese];
                [UIAlertView bk_showAlertViewWithTitle:@"切换城市" message:msg cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    if (buttonIndex == 1) {
                        //保存新的城市到偏好设置plist（NSUserDefaults）中
                        [[NSUserDefaults standardUserDefaults] setObject:cityChinese forKey:kCurrentCityName];
                        //立刻把内存中的plist存入到沙盒中
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        //发城市改变的全局通知
                        [[NSNotificationCenter defaultCenter] postNotificationName:kCurrentCityChangedNotification object:self userInfo:@{kCityChangeKey:cityChinese}];
                        
                    }
                }];
                
            }
            
        }];
    }
    
    
    
}





@end
