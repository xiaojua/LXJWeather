//
//  LXJLeftViewController.m
//  LXJWeather
//
//  Created by xiaojuan on 17/2/8.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import "LXJLeftViewController.h"
#import "LXJCityTableViewController.h"

/* 表格行数 */
#define CELL_C self.cellTextArr.count
/* 表格行高 */
#define CELL_H 55

@interface LXJLeftViewController ()<UITableViewDelegate, UITableViewDataSource>

/* 存储cell文字数组 */
@property (nonatomic, strong)NSArray *cellTextArr;
/* 存储cell图片数组 */
@property (nonatomic, strong)NSArray *cellImageArr;

@end

@implementation LXJLeftViewController

#pragma mark - lazy懒加载
/* 存储cell文字数组 */
- (NSArray *)cellTextArr{
    if (!_cellTextArr) {
        _cellTextArr = @[@"切换城市", @"其它"];
    }
    return _cellTextArr;
}
/* 存储cell图片数组 */
- (NSArray *)cellImageArr{
    if (!_cellImageArr) {
        _cellImageArr = @[@"IconSettings", @"IconProfile"];
    }
    return _cellImageArr;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /* 创建表格 */
    [self createTableView];
    
}

#pragma mark - function方法
/* 创建表格 */
- (void)createTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, (SCREEN_H-CELL_H*CELL_C) * 0.5, SCREEN_W, CELL_H*2)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellTextArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.cellTextArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.cellImageArr[indexPath.row]];
    return cell;
}
/* 表格的行高 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_H;
}
/* 点中某一行跳到指定页面 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /* 点中某一行有动画效果 */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /* 点中切换城市（第0行）跳到城市列表页面 */
    if (indexPath.row == 0) {
        LXJCityTableViewController *cityVC = [[LXJCityTableViewController alloc]init];
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:cityVC];
        [self presentViewController:nvc animated:YES completion:nil];
    }
}

@end
