//
//  BRSearchBar.m
//  ManageGroup
//
//  Created by 任波 on 17/2/23.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "BRSearchBar.h"

@implementation BRSearchBar
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    UITextField *searchField;
    NSArray *subviewArr = self.subviews;
    for(int i = 0; i < subviewArr.count ; i++) {
        UIView *viewSub = [subviewArr objectAtIndex:i];
        NSArray *arrSub = viewSub.subviews;
        for (int j = 0; j < arrSub.count ; j++) {
            id tempId = [arrSub objectAtIndex:j];
            if([tempId isKindOfClass:[UITextField class]]) {
                searchField = (UITextField *)tempId;
            }
        }
    }
    //自定义UISearchBar
    if(searchField) {
        searchField.placeholder = @"搜索";
        searchField.borderStyle = UITextBorderStyleRoundedRect;
        searchField.backgroundColor = [UIColor whiteColor];
        searchField.textColor = [UIColor blackColor];
        SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@ %@", @"setCenter", @"Placeholder:"]);
        if ([self respondsToSelector:centerSelector]) {
            NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            invocation.target = self;
            invocation.selector = centerSelector;
            [invocation invoke];
        }
    }
    
    //外部背景
    UIView *outView = [[UIView alloc] initWithFrame:self.bounds];
    [outView setBackgroundColor:[UIColor whiteColor]];
    [self insertSubview:outView atIndex:1];
}

@end
