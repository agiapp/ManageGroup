//
//  BRContactsCell.h
//  ManageGroup
//
//  Created by 任波 on 17/2/23.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BRContactsModel;
@interface BRContactsCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UILabel *activeTimeLabel;
// 模型对象
@property (nonatomic, strong) BRContactsModel *model;

@end
