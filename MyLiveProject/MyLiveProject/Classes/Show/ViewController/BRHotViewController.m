//
//  BRHotViewController.m
//  MyLiveProject
//
//  Created by 任波 on 17/2/8.
//  Copyright © 2017年 RENB. All rights reserved.
//

#import "BRHotViewController.h"
#import "BRLiveHandler.h"
#import "BRLiveCell.h"

@interface BRHotViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *liveModelArr;

@end

@implementation BRHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    // 1. 初始化UI
    [self initUI];
    // 2. 加载数据
    [self loadData];
}

#pragma mark - 第1步：初始化UI
- (void)initUI {
    self.tableView.hidden = NO;
}

#pragma mark - 第2步：加载数据
- (void)loadData {
    [BRLiveHandler executeGetHotLiveTaskWithSuccess:^(id obj) {
        MYLog(@"请求热门直播的信息：%@", obj);
        [self.liveModelArr addObjectsFromArray:obj];
        [self.tableView reloadData];
    } failed:^(id error) {
        MYLog(@"请求错误：%@", error);
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 78 + SCREEN_WIDTH;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.liveModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    BRLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BRLiveCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.liveModelArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSMutableArray *)liveModelArr {
    if (!_liveModelArr) {
        _liveModelArr = [NSMutableArray array];
    }
    return _liveModelArr;
}

@end
