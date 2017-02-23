//
//  BRGroupModel.h
//  ManageGroup
//
//  Created by 任波 on 17/2/23.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRGroupModel : NSObject
/** 分组ID */
@property (nonatomic, copy) NSString *groupID;
/** 分组名称 */
@property (nonatomic, copy) NSString *groupName;
/** 分组类型(1表示未分组, 2表示自定义分组) */
@property (nonatomic, assign) NSInteger groupType;
/** 成员个数(患者个数) */
@property (nonatomic, assign) NSInteger memberNum;

@end
