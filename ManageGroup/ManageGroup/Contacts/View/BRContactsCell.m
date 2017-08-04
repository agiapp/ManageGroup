//
//  BRContactsCell.m
//  ManageGroup
//
//  Created by 任波 on 17/2/23.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "BRContactsCell.h"
#import "BRContactsModel.h"

// 等比例适配系数
#define kScaleFit (SCREEN_WIDTH / 375.0f)

@interface BRContactsCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UILabel *activeTimeLabel;

@end

@implementation BRContactsCell
#pragma mark - 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.describeLabel];
        [self.contentView addSubview:self.activeTimeLabel];
    }
    return self;
}

#pragma mark - setter
- (void)setModel:(BRContactsModel *)model {
    _model = model;
    _iconImageView.image = [UIImage imageNamed:@"default.jpg"];
    _nameLabel.text = model.name;
    _describeLabel.text = model.desc;
    _activeTimeLabel.text = model.activeTime;
}

#pragma mark - 设置子视图的frame
- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconImageView.frame = CGRectMake(10, 6 * kScaleFit, 48 * kScaleFit, 48 * kScaleFit);
    self.nameLabel.frame = CGRectMake(10 + 56 * kScaleFit, 10 * kScaleFit, 150 * kScaleFit, 20 * kScaleFit);
    self.describeLabel.frame = CGRectMake(10 + 56 * kScaleFit, 35 * kScaleFit, 210 * kScaleFit, 15 * kScaleFit);
    self.activeTimeLabel.frame = CGRectMake(SCREEN_WIDTH - 100 * kScaleFit - 10, 10 * kScaleFit, 100 * kScaleFit, 20 * kScaleFit);
}

#pragma mark - 懒加载
- (UIImageView *)iconImageView {
    if(_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.cornerRadius = 24 / 375.0 * SCREEN_WIDTH;
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;
}

- (UILabel *)nameLabel {
    if(_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorWithRed:0.21 green:0.21 blue:0.21 alpha:1.0];
        _nameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _nameLabel;
}

- (UILabel *)describeLabel {
    if(_describeLabel == nil) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.textColor = [UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0];
        _describeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _describeLabel;
}

- (UILabel *)activeTimeLabel {
    if(_activeTimeLabel == nil) {
        _activeTimeLabel = [[UILabel alloc] init];
        _activeTimeLabel.textColor = [UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0];
        _activeTimeLabel.textAlignment = NSTextAlignmentRight;
        _activeTimeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _activeTimeLabel;
}


@end
