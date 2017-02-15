//
//  LXJDailyCell.m
//  LXJWeather
//
//  Created by xiaojuan on 17/2/14.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import "LXJDailyCell.h"

@interface LXJDailyCell ()
/* 日期（星期几） */
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
/* 每天天气图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
/* 最高温度 */
@property (weak, nonatomic) IBOutlet UILabel *hiTempLabel;
/* 最低温度 */
@property (weak, nonatomic) IBOutlet UILabel *loTempLabel;


@end


@implementation LXJDailyCell

+ (LXJDailyCell *)getDailyCell{
    return [[[NSBundle mainBundle] loadNibNamed:@"LXJDailyCell" owner:self options:nil] firstObject];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //此三行代码用于去掉cell左侧的空隙
        self.separatorInset = UIEdgeInsetsZero;
        self.layoutMargins = UIEdgeInsetsZero;
        self.preservesSuperviewLayoutMargins = NO;
        
    }
    return self;
}

//重写set方法
- (void)setDailyModel:(LXJDaily *)dailyModel{
    self.weekLabel.text = dailyModel.preDateStr;
    NSString *iconUrlStr = [IMAGE_BASE_URL stringByAppendingFormat:@"%@.png", dailyModel.iconCodeStr];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconUrlStr] placeholderImage:nil];
    self.hiTempLabel.text = dailyModel.hiTemp;
    self.loTempLabel.text = dailyModel.loTemp;
}








@end
