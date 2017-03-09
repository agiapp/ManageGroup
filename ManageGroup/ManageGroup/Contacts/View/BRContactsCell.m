//
//  BRContactsCell.m
//  ManageGroup
//
//  Created by 任波 on 17/2/23.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "BRContactsCell.h"
#import "BRContactsModel.h"

@interface BRContactsCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UILabel *activeTimeLabel;

@end

@implementation BRContactsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.describeLabel];
        [self.contentView addSubview:self.activeTimeLabel];
    }
    return self;
}

- (void)setModel:(BRContactsModel *)model {
    _model = model;
    _iconImageView.image = [UIImage imageNamed:@"default.jpg"];
    _nameLabel.text = model.name;
    _describeLabel.text = model.describe;
    _activeTimeLabel.text = model.activeTime;
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

#pragma mark - 设置子视图的frame
- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconImageView.frame = CGRectMake(10, 6 / 375.0 * SCREEN_WIDTH, 48 / 375.0 * SCREEN_WIDTH, 48 / 375.0 * SCREEN_WIDTH);
    self.nameLabel.frame = CGRectMake(10 + 56 / 375.0 * SCREEN_WIDTH, 10 / 375.0 * SCREEN_WIDTH, 150 / 375.0 * SCREEN_WIDTH, 20 / 375.0 * SCREEN_WIDTH);
    self.describeLabel.frame = CGRectMake(10 + 56 / 375.0 * SCREEN_WIDTH, 35 / 375.0 * SCREEN_WIDTH, 210 / 375.0 * SCREEN_WIDTH, 15 / 375.0 * SCREEN_WIDTH);
    self.activeTimeLabel.frame = CGRectMake(SCREEN_WIDTH - 100 / 375.0 * SCREEN_WIDTH - 10, 10 / 375.0 * SCREEN_WIDTH, 100 / 375.0 * SCREEN_WIDTH, 20 / 375.0 * SCREEN_WIDTH);
    
}


@end
