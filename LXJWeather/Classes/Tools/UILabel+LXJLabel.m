//
//  UILabel+LXJLabel.m
//  LXJWeather
//
//  Created by xiaojuan on 17/2/8.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

#import "UILabel+LXJLabel.h"

@implementation UILabel (LXJLabel)

+ (UILabel *)labelWithFrame:(CGRect)frame{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:30];
    return label;
}

@end
