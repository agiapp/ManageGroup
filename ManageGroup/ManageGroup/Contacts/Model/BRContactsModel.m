//
//  BRContactsModel.m
//  ManageGroup
//
//  Created by 任波 on 17/2/23.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "BRContactsModel.h"
#import <MJExtension.h>

@implementation BRContactsModel

#pragma mark - 将属性名换为其他key去字典中取值（避免属性名为系统关键字）
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
                @"ID" : @"id",
                @"desc" : @"description"
            };
}

#pragma mark - 驼峰属性转成下划线key去字典中取值
+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    return [propertyName mj_underlineFromCamel];
}

@end
