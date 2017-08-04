# 项目说明
此DEMO抽取的是公司上线项目的管理联系人模块，使用的是MVC架构。如果觉得不错，希望各位大神支持一下😊

# 效果图

![运行效果图](https://github.com/borenfocus/ManageGroup/blob/master/ManageGroup/%E6%95%88%E6%9E%9C%E5%9B%BE.gif)

# 项目结构

![项目结构图](https://github.com/borenfocus/ManageGroup/blob/master/ManageGroup/a.png)

# 代码

- 模拟网络请求，获取本地文件的内容，使用MJExtension将JSON转换成数据模型。

```json
{
    "code": "1000",
    "ret_code": "0",
    "ret_msg": "操作成功",
    "groups": [
        {
            "group_id": "35ea5621962baa0e2b3dca2d4",
            "group_name": "未分组",
            "group_type": "1",
            "member_num": "3",
            "contacts": [
                {
                    "id": "5848ead4d9e8d7b31172a285",
                    "head_img": "default.png",
                    "name": "张三",
                    "description": "[WIFI在线] 欢迎给我留言",
                    "active_time": "12:50"
                },
                {
                    "id": "a243e23848ea43fddfs347b1",
                    "head_img": "default.png",
                    "name": "李四",
                    "description": "[手机在线] 更新了日志",
                    "active_time": "08:20"
                },
                {
                    "id": "fsdfre522a43fddfs337b1",
                    "head_img": "default.png",
                    "name": "王五",
                    "description": "[4G在线] 更新了说说",
                    "active_time": "星期三"
                }
            ]
        },
        {
            "group_id": "80adasdas092dee232b74ca232",
            "group_name": "高中同学",
            "group_type": "2",
            "member_num": "2",
            "contacts": [
                {
                    "id": "e323e65842ea43fd3sde367e4",
                    "head_img": "default.png",
                    "name": "小明",
                    "description": "[电脑在线] 好好学习，天天向上",
                    "active_time": "昨天"
                },
                {
                    "id": "dwedwe3242cdw43fd3s3227e4",
                    "head_img": "default.png",
                    "name": "张小龙",
                    "description": "[离线请留言] 哥是最牛逼的产品经理",
                    "active_time": "2017/2/22"
                }
            ]
        },
        {
            "group_id": "dwe2357ec923e0e2b23a47",
            "group_name": "大学同学",
            "group_type": "2",
            "member_num": "1",
            "contacts": [
                {
                    "id": "2dd4ddf65842dsd323d44fscsa21",
                    "head_img": "default.png",
                    "name": "乔布斯",
                    "description": "[离线] 把产品做到极致",
                    "active_time": "2017/2/22"
                }
            ]
        },
        {
            "group_id": "58ae5800963bee0e2b74ca48",
            "group_name": "同事",
            "group_type": "2",
            "member_num": "0"
        },
        {
            "group_id": "fdsds3233463bee0e2eeweffw",
            "group_name": "黑名单",
            "group_type": "2",
            "member_num": "0"
        }
    ]
}
```

- 指定哪些行的 cell 可以进行编辑 (UITableViewDataSource 协议方法) 

```objective-c
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return NO; // 第一行不能编辑
    } else {
        return YES;
    }
}
```

- 单元格返回的编辑风格(添加/删除/不可编辑,三种风格)(UITableViewDelegate协议中方法) 

```
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
```

- 提交编辑状态/效果 (UITableViewDataSource协议中方法)

```objective-c
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //判断编辑状态是删除时 (点击 删除 按钮的操作)
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"删除分组！");
    }
}
```

- 移动分组

```objective-c
/** 指定tableView那些行(cell)可以移动 */
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return NO; //cell不能移动
    } else {
        return YES; //cell可以移动
    }
}
/** 移动cell后的操作:数据源进行更新 */
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    //1. 存储将要被移动的位置的对象
    NSString *str = [_groupModelArr objectAtIndex:sourceIndexPath.row];
    //2. 将对象从原位置移除
    [self.groupModelArr removeObjectAtIndex:sourceIndexPath.row];
    //3. 将对象插入到新位置
    [self.groupModelArr insertObject:str atIndex:destinationIndexPath.row];
    //刷新表格
    [self.tableView reloadData];
}
```

