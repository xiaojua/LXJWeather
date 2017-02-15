//
//  LXJMainViewController.m
//  LXJWeather
//
//  Created by xiaojuan on 17/2/7.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import "LXJMainViewController.h"
#import "LXJHearerView.h"
#import "RESideMenu.h"
#import "LXJLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import "LXJNetworkManager.h"
#import "LXJCurrentWeatherModel.h"
#import "LXJDataManager.h"
#import "LXJDaily.h"
#import "LXJDailyCell.h"
#import "LXJFooterView.h"



@interface LXJMainViewController ()<UITableViewDelegate, UITableViewDataSource>

/* tableView */
@property (nonatomic, weak)UITableView *tableView;
/* tableView的headerView */
@property (nonatomic, strong)LXJHearerView *headerView;
/* tableView的footerView */
@property (nonatomic, strong)LXJFooterView *footerView;
/* 记录用户位置的属性 */
@property (nonatomic, strong)CLLocation *userLocation;
/* 地理编码 */
@property (nonatomic, strong)CLGeocoder *geocoder;
/* 当前天气 */
@property (nonatomic, strong)LXJCurrentWeatherModel *currentWeather;
/* 记录每天天气的数组 */
@property (nonatomic, strong)NSArray *dailyArr;
/* 脚部视图数据 */
@property (nonatomic, strong)LXJLivingIndexModel *life;



@end

@implementation LXJMainViewController

static NSString * const reuseIdentifier = @"DailyCell";

#pragma mark - 懒加载lazy
- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor redColor];
    
    //MYLog(@"高:%f,宽:%f", SCREEN_H,SCREEN_W);
    /* 
     iPhone7：高667.000000，宽375.000000
     iPhone7P：高736.000000，宽414.000000
     带电池条
     */
    
    /* 1、添加监听 */
    [self listenNotification];
    
    /* 2、创建tableView */
    [self createTableView];
    /* 3、创建tableView的headerView */
    [self createTableHeaderView];
    /* 3.2、创建tableView的footerView */
    [self createTableFooterView];
    
    /* 4.创建添加刷新控件 */
    //[self createRefreshControl];
    
    /* 5、获取用户位置然后发送网络请求 */
    [self getLocationAndSendRequest];
    
    
    //注册dailyCell
    [self.tableView registerNib:[UINib nibWithNibName:@"LXJDailyCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
    
}


#pragma mark - 方法function
/* 添加监听 */
- (void)listenNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCityChange:) name:kCurrentCityChangedNotification object:nil];
}
/* 移除监听 */
//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
/* 城市改变通知后 */
- (void)didCityChange:(NSNotification *)noti{
    //隐藏侧边的控制器
    [self.sideMenuViewController hideMenuViewController];
    //获取通知里面当前城市
    NSString *cityName = noti.userInfo[kCityChangeKey];
    //把获取到的城市赋值给头部视图的citylable
    self.headerView.cityLabel.text = cityName;
    
    //使用地理编码把中文的名字改成经纬度（如果网络请求时需要经纬度）
    [self.geocoder geocodeAddressString:cityName completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error) {
            //把地标数组中的最后一个经纬度赋值给userLocation
            self.userLocation = [placemarks lastObject].location;
            //发送对城市的网络请求
            [self sendRequest];
        }
    }];
    
}
/* 获取用户位置然后发送网络请求 */
- (void)getLocationAndSendRequest{
    [LXJLocationManager getUserLocation:^(double latitude, double longitude) {
        //将获取到的用户位置赋值给当前用户位置
        self.userLocation = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
        //获取完地理位置后先把头部视图上的城市名字改掉
        [self.geocoder reverseGeocodeLocation:self.userLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            //获取城市名字
            CLPlacemark *placeMark = placemarks.lastObject;
            NSString *cityName = placeMark.locality;
            MYLog(@"获取到地理位置后的城市名字：%@", cityName);
            cityName = [cityName substringToIndex:(cityName.length - 1)];
            self.headerView.cityLabel.text = cityName;
        }];


        
        
        //发送网络请求
        [self sendRequest];
    }];
}
/* 创建刷新控件 */
- (void)createRefreshControl{
    //前提是必须定位到用户位置
    //创建头部刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(sendRequest)];
    //设置属性
    //header.lastUpdatedTimeLabel.hidden = YES;
    
    
    //把刷新添加到表格
    self.tableView.mj_header = header;
    
    //开始刷新
    [header beginRefreshing];
    
}
#pragma mark - 发送对城市的网络请求
- (void)sendRequest
{
    /* 发送网络请求获取数据 */
    //当前城市天气数据
    NSString *urlStr = [BASE_URL stringByAppendingString:@"/now"];
    //获取当前城市
    NSString *cityName = kCurrentCity ? kCurrentCity : @"北京";
    MYLog(@"发送网络请求需要的城市名字：%@", cityName);
    NSDictionary *param = @{@"city" : cityName,
                            @"key" : KEY,
                            @"lang" :@"zh-cn"
                            };
    [LXJNetworkManager sendRequestWithUrl:urlStr paratemers:param success:^(id responseObject) {
        MYLog(@"%@,%@",responseObject,[NSThread currentThread]);
        self.currentWeather = [LXJDataManager getCurrentWeatherData:responseObject];
        MYLog(@"%@", self.currentWeather.precipitationStr);
        /* 更新头部视图 */
        [self updateHeaderView];
        /* 更新脚部视图 */
        [self updateFooterView];
        
        /* 刷新表格(网络请求是异步的Async...) */
        [self.tableView reloadData];
        /* 结束刷新 */
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        MYLog(@"%@", error);
        /* 结束刷新 */
        [self.tableView.mj_header endRefreshing];
    }];
    
    //每天天气数据
    NSString *dailyUrlStr = [BASE_URL stringByAppendingString:@"forecast"];
    [LXJNetworkManager sendRequestWithUrl:dailyUrlStr paratemers:param success:^(id responseObject) {
        MYLog(@"%@,%@", [NSThread currentThread], responseObject);
        self.dailyArr = [LXJDataManager getAllDailyData:responseObject];
        /* 更新头部视图 */
        [self updateHeaderView];
        /* 更新脚部视图 */
        [self updateFooterView];
        /* 刷新表格 */
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        MYLog(@"%@", error);
        /* 结束刷新 */
        [self.tableView.mj_header endRefreshing];
    }];
    
    //底部部分数据
    NSString *lifeUrlStr = [BASE_URL stringByAppendingString:@"suggestion"];
    NSDictionary *paramLife = @{
                                @"city" : cityName,
                                @"key" : KEY
                                };
    [LXJNetworkManager sendRequestWithUrl:lifeUrlStr paratemers:paramLife success:^(id responseObject) {
        MYLog(@"%@,%@",[NSThread currentThread], responseObject);
        self.life = [LXJDataManager getLifeData:responseObject];
        MYLog(@"%@",self.life.sportDescStr);
        
        /* 更新头部视图 */
        [self updateHeaderView];
        /* 更新脚部视图 */
        [self updateFooterView];
        /* 刷新表格 */
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        /* 结束刷新 */
        [self.tableView.mj_header endRefreshing];
    }];
    
}
/* 更新头部视图 */
- (void)updateHeaderView{
    //1.更新头部视图中的城市名字
    if (self.userLocation) {
        [self.geocoder reverseGeocodeLocation:self.userLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            //获取城市名字
            CLPlacemark *placeMark = placemarks.lastObject;
            NSString *cityName = placeMark.locality;
            MYLog(@"获取到地理位置后的城市名字：%@", cityName);
            cityName = [cityName substringToIndex:(cityName.length - 1)];
            self.headerView.cityLabel.text = cityName;
        }];
    }
    NSString *urlStr = [IMAGE_BASE_URL stringByAppendingFormat:@"%@.png",self.currentWeather.weatherIconUrl];
    [self.headerView.iconView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
    self.headerView.iconView.backgroundColor = [UIColor clearColor];
    self.headerView.weatherLabel.text = self.currentWeather.weather;
    self.headerView.temLabel.text = self.currentWeather.currentTemp;
    LXJDaily *daily = self.dailyArr[0];
    self.headerView.hiloLabel.text = [daily.hiTemp stringByAppendingFormat:@"°C/%@°C", daily.loTemp];
    MYLog(@"%@,%@,%@",urlStr,self.headerView.weatherLabel.text,self.headerView.temLabel.text);
}
/* 更新脚部视图 */
- (void)updateFooterView{
    LXJDaily *daily = self.dailyArr[0];
    self.footerView.sunRiseLabel.text = daily.sunRiseStr;
    self.footerView.sunSetLabel.text = daily.sunSetStr;
    self.footerView.rainPLabel.text = daily.rainPStr;
    self.footerView.humidityPLabel.text = daily.humidityPStr;
    
    self.footerView.windSpeedLabel.text = self.currentWeather.windSpeedStr;
    self.footerView.windDirLabel.text = self.currentWeather.windDirStr;
    self.footerView.feelTempLabel.text = self.currentWeather.feelTempStr;
    self.footerView.precipitationLabel.text = self.currentWeather.precipitationStr;
    self.footerView.pressureLabel.text = self.currentWeather.pressureStr;
    
    self.footerView.sportLabel.text = self.life.sportStr;
    self.footerView.sportDescLabel.text = self.life.sportDescStr;
    self.footerView.ultravioletLabel.text = self.life.ultravioletStr;
    self.footerView.ultravioletDescLabel.text = self.life.ultravioletDescStr;
    
}

#pragma mark - 关于table表格的方法
/* 创建tableView */
- (void)createTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.pagingEnabled = YES;
    [self.view addSubview:tableView];
}
/* 创建tableView的headerView */
- (void)createTableHeaderView{
    self.headerView = [[LXJHearerView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.headerView.menuButton addTarget:self action:@selector(popLeftVC) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = self.headerView;
}
/* 滑出左侧的VC */
- (void)popLeftVC{
    [self.sideMenuViewController presentLeftMenuViewController];
}
/* 创建tableView的footerView */
- (void)createTableFooterView{
    self.footerView = [[LXJFooterView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.tableView.tableFooterView = self.footerView;
}



#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dailyArr ? self.dailyArr.count : 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LXJDailyCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    LXJDaily *daily = self.dailyArr[indexPath.row];
    cell.dailyModel = daily;
    
    
    return cell;
}
/* 表格行高 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //行数
    NSInteger rowC = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    return SCREEN_H / rowC;
}
/* 选中某一行后的效果 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /* 选中某行有闪一下的动态效果 */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 设置
/* 设置状态栏为白色系(电池条上的文字即为白色) */
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}






@end
