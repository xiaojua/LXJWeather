//
//  LXJCityTableViewController.m
//  LXJWeather
//
//  Created by xiaojuan on 17/2/9.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import "LXJCityTableViewController.h"
#import "LXJCityGroupModel.h"
#import "LXJDataManager.h"


@interface LXJCityTableViewController ()

/* 存储所有城市组的数据 */
@property (nonatomic, strong)NSArray *allCityGroups;

@end

@implementation LXJCityTableViewController
#pragma mark - 懒加载lazy
- (NSArray *)allCityGroups{
    if (!_allCityGroups) {
        _allCityGroups = [LXJDataManager getAllCityGroups];
    }
    return _allCityGroups;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    /* 导航栏标题 */
    self.navigationItem.title = @"请选择城市";
    /* 返回按钮，返回到发起present界面 */
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickBackItem)];
}
#pragma mark - 方法function
/* 返回按钮，返回到发起present界面 */
- (void)clickBackItem{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source, delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.allCityGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LXJCityGroupModel *cityGroup = self.allCityGroups[section];
    return cityGroup.cities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    LXJCityGroupModel *cityGroup = self.allCityGroups[indexPath.section];
    cell.textLabel.text = cityGroup.cities[indexPath.row];
    cell.accessoryType = [kCurrentCity isEqualToString:cityGroup.cities[indexPath.row]] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    
    return cell;
}

/* 每个分区头标题，即城市组名称 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    LXJCityGroupModel *cityGroup = self.allCityGroups[section];
    return cityGroup.title;
}
/* 表格右侧索引 */
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *titles = [NSMutableArray array];
    for (LXJCityGroupModel *cityGroup in self.allCityGroups) {
        [titles addObject:cityGroup.title];
    }
    return titles;
}

/* 选择某一行返回 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //把选中那一行的城市名字从模型中拿出来
    LXJCityGroupModel *cityGroup = self.allCityGroups[indexPath.section];
    NSString *cityName = cityGroup.cities[indexPath.row];
    //更新新城市
    [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:kCurrentCityName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //发城市改变的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCurrentCityChangedNotification object:self userInfo:@{kCityChangeKey:cityName}];
    //返回
    [self clickBackItem];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
