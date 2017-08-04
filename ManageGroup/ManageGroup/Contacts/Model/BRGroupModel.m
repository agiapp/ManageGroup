//
//  BRGroupModel.m
//  ManageGroup
//
//  Created by 任波 on 17/2/23.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "BRGroupModel.h"
#import <MJExtension.h>
#import "BRContactsModel.h"

@implementation BRGroupModel

#pragma mark - 驼峰属性转成下划线key去字典中取值
+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    return [propertyName mj_underlineFromCamel];
}

#pragma mark - 属性为数组类型时，要指定数组元素对应的模型类(解析类)
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"contacts": [BRContactsModel class]};
}

@end
