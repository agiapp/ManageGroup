//
//  BRContactsViewController.m
//  ManageGroup
//
//  Created by 任波 on 17/2/23.
//  Copyright © 2017年 renbo. All rights reserved.
//
//  最新代码下载地址：https://github.com/borenfocus/ManageGroup

#import "BRContactsViewController.h"
#import "BRContactsCell.h"
#import "BRContactsModel.h"
#import "BRGroupModel.h"
#import "BRGroupViewController.h"
#import "BRSearchBarView.h"
#import <MJExtension.h>

@interface BRContactsViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSIndexPath *_indexPath; // 保存当前选中的单元格
}
/** 搜索框视图 */
@property (nonatomic,strong) BRSearchBarView *searchBarView;
@property (nonatomic, strong) UITableView *tableView;
/** 保存分组数据模型 */
@property (nonatomic, strong) NSMutableArray *groupModelArr;
/** 保存旋转状态(展开/折叠) */
@property (nonatomic, strong) NSMutableArray *switchArr;

@end

@implementation BRContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"联系人";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor redColor];
    [self initUI];
    [self loadData];
}

- (void)initUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[self getGroupManageButton]];
    self.tableView.hidden = NO;
}

- (void)loadData {
    self.groupModelArr = nil;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 加载本地数据（实际开发中这里写网络请求，从服务端请求数据...）
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"contacts" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"数据内容：%@", jsonObj);
        NSString *retCode = jsonObj[@"ret_code"];
        if ([retCode isEqualToString:successFlag]) {
            // 解析返回的结果：JSON转数据模型
            NSMutableArray *groupModelArr = [BRGroupModel mj_objectArrayWithKeyValuesArray:jsonObj[@"groups"]];
            self.groupModelArr = groupModelArr;
            
            for (NSInteger i = 0; i < self.groupModelArr.count; i++) {
                // 加个判断，防止多次重复调用这个方法时，造成数据累加无限添加
                if (self.switchArr.count < self.groupModelArr.count) {
                    [self.switchArr addObject:@NO];
                }
            }
            // 回到主线程刷新表格
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    });
}

- (UIButton *)getGroupManageButton {
    // 设置左上角的返回按钮 (非根控制器才需要设置返回按钮)
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 31, 22, 22)];
    [btn setImage:[UIImage imageNamed:@"group_manage"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickToGroupManagement) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)clickToGroupManagement {
    BRGroupViewController *groupVC = [[BRGroupViewController alloc]init];
    groupVC.groupModelArr = self.groupModelArr; //传值
    [self.navigationController pushViewController:groupVC animated:YES];
}

- (BRSearchBarView *)searchBarView {
    if(_searchBarView == nil) {
        _searchBarView = [[BRSearchBarView alloc]initWithFrame:CGRectMake(0, kStatusBarAndNaviBarH, self.view.frame.size.width, 50)];
    }
    return _searchBarView;
}

#pragma mark- 懒加载视图
- (UITableView *)tableView {
    if(_tableView == nil) {
        // 原点位置是(0,0)
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarAndNaviBarH, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        // 设置表格头视图
        _tableView.tableHeaderView = self.searchBarView;
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

#pragma mark- UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groupModelArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BRGroupModel *model = self.groupModelArr[section];
    if ([self.switchArr[section] boolValue] == YES) {
        return model.contacts.count;
    } else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BRContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[BRContactsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    BRGroupModel *gModel = self.groupModelArr[indexPath.section];
    cell.model = gModel.contacts[indexPath.row];
    // 添加单元格的长按手势
    UILongPressGestureRecognizer *longPressed = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressToDo:)];
    longPressed.minimumPressDuration = 1;
    [cell.contentView addGestureRecognizer:longPressed];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    // 取消选中后的高亮状态(默认是：选中单元格后一直处于高亮状态，直到下次重新选择)
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _indexPath = indexPath;
    // 获取当前患者对象,并传给详情页面
    BRGroupModel *gModel = self.groupModelArr[indexPath.section];
    BRContactsModel *model = gModel.contacts[indexPath.row];
    NSLog(@"点击了：%@", model.name);
}
/** 长按手势的执行方法 */
- (void)longPressToDo:(UILongPressGestureRecognizer *)gesture {
    if(gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gesture locationInView:self.tableView];
        _indexPath = [self.tableView indexPathForRowAtPoint:point];
        // 弹出框
        [self gestureAlert];
        if(_indexPath == nil) return ;
    }
}
/** 弹出框方法 */
- (void)gestureAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了删除");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"移至分组" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了移至分组");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60 / 375.0 * SCREEN_WIDTH;
}
// 分区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50 / 375.0 * SCREEN_WIDTH;
}
// 分区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10.0f;
    } else {
        return 1.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320 / 375.0 * SCREEN_WIDTH, 50 / 375.0 * SCREEN_WIDTH)];
    view.backgroundColor = [UIColor whiteColor];
    // 边界线
    UIView *borderView = [[UIView alloc]initWithFrame:CGRectMake(0, 50 / 375.0 * SCREEN_WIDTH, SCREEN_WIDTH, 0.5)];
    borderView.backgroundColor = RGB_HEX(0xC8C7CC);
    [view addSubview:borderView];
    // 展开箭头
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15 / 375.0 * SCREEN_WIDTH, 19 / 375.0 * SCREEN_WIDTH, 14 / 375.0 * SCREEN_WIDTH, 12 / 375.0 * SCREEN_WIDTH)];
    imageView.image = [UIImage imageNamed:@"pulldownList.png"];
    [view addSubview:imageView];
    // 分组名Label
    UILabel *groupLable = [[UILabel alloc]initWithFrame:CGRectMake(45 / 375.0 * SCREEN_WIDTH, 0, SCREEN_WIDTH, 50 / 375.0 * SCREEN_WIDTH)];
    BRGroupModel *model = _groupModelArr[section];
    groupLable.text = [NSString stringWithFormat:@"%@ [ %ld ]", model.groupName, (long)model.memberNum];
    groupLable.textColor = [UIColor colorWithRed:0.21 green:0.21 blue:0.21 alpha:1.0];
    groupLable.font = [UIFont systemFontOfSize:16];
    [view addSubview:groupLable];
    
    view.userInteractionEnabled = YES;
    // 初始化一个手势
    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openClick:)];
    // 给view添加手势
    [view addGestureRecognizer:myTap];
    view.tag = 1000 + section;
    
    CGFloat rota;
    if ([self.switchArr[section] boolValue] == NO) {
        rota = 0;
    } else {
        rota = M_PI_2; //π/2
    }
    imageView.transform = CGAffineTransformMakeRotation(rota);//箭头偏移π/2
    return view;
}

- (void)openClick:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    NSInteger section = sender.view.tag - 1000;
    if ([self.switchArr[section] boolValue] == NO) {
        [self.switchArr replaceObjectAtIndex:section withObject:@YES];
    } else {
        [self.switchArr replaceObjectAtIndex:section withObject:@NO];
    }
    // 刷新分区
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *clearView = [[UIView alloc]init];
    clearView.backgroundColor = [UIColor clearColor];
    return clearView;
}

- (NSMutableArray *)groupModelArr {
    if (!_groupModelArr) {
        _groupModelArr = [[NSMutableArray alloc] init];
    }
    return _groupModelArr;
}

- (NSMutableArray *)switchArr {
    if (!_switchArr) {
        _switchArr = [[NSMutableArray alloc]init];
    }
    return _switchArr;
}

@end
