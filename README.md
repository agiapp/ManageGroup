# ManageGroup
管理分组和联系人

# 效果图

![运行效果图](https://github.com/borenfocus/ManageGroup/blob/master/ManageGroup/%E6%95%88%E6%9E%9C%E5%9B%BE.gif)

# 项目结构

![项目结构图](https://github.com/borenfocus/ManageGroup/blob/master/ManageGroup/a.png)

# 关键代码

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

