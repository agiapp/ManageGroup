//
//  BRSearchBarView.m
//  ManageGroup
//
//  Created by 任波 on 17/2/23.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "BRSearchBarView.h"
#import "BRSearchBar.h"

@interface BRSearchBarView ()<UISearchBarDelegate>
/** 搜索框 */
@property (nonatomic,strong) BRSearchBar *searchBar;

@end
@implementation BRSearchBarView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.searchBar];
    }
    return self;
}

- (BRSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[BRSearchBar alloc]initWithFrame:CGRectZero];
        _searchBar.layer.cornerRadius = 15;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.layer.borderWidth = 0.5;
        _searchBar.layer.borderColor = [UIColor grayColor].CGColor;
        _searchBar.delegate = self;
        _searchBar.frame = CGRectMake(20, 10, SCREEN_WIDTH - 40, 30);
    }
    return _searchBar;
}

@end
