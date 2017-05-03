//
//  YXBroadcastListController.m
//  YXLiveApp
//
//  Created by YuXiang on 2017/5/2.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import "YXBroadcastListController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "YXLiveViewController.h"
#import "YXLiveCell.h"
#import "YXLiveItem.h"
#import "YXLiveEntity.h"

static NSString * const ID = @"cell";
@interface YXBroadcastListController ()<UITableViewDelegate,UITableViewDataSource>
/** 直播 */
@property(nonatomic, strong) NSMutableArray *lives;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) YXLiveEntity *liveEntity;
@end

@implementation YXBroadcastListController

- (NSMutableArray *)lives {
    if (!_lives) {
        _lives = [[NSMutableArray alloc] init];
    }
    return _lives;
}

- (YXLiveEntity *)liveEntity {
    if (!_liveEntity) {
        _liveEntity = [[YXLiveEntity alloc] init];
    }
    return _liveEntity;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"直播列表";
    
    [self config];
    [self loadData];
}

- (void)config {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"YXLiveCell" bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadData {
    // 映客数据url
    NSString *urlStr = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1";
    @weakify(self);
    [[self.liveEntity.fetchLiveEntityCommand execute:urlStr] subscribeNext:^(NSArray *arr) {
        @strongify(self);
        [self.lives addObjectsFromArray:arr];
        [self.tableView reloadData];
    }error:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lives.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.liveItem = self.lives[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXLiveViewController *liveVc = [[YXLiveViewController alloc] init];
    liveVc.live = self.lives[indexPath.row];
    
    [self presentViewController:liveVc animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 430;
}

@end
