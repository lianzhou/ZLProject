//
//  BaseTableViewController.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/14.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MJRefresh.h"
@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum=1;
    self.totalCount=@"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init ];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame=CGRectZero;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedRowHeight = kRowHeight;
        _tableView.sectionIndexColor = KViewBgColor;
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;// est和代理 可选1个
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=[UIColor clearColor];
        //禁止下拉
        //_myTablelist.bounces=NO;
        // 隐藏UITableView的滚动条以及修改滚动条的颜色
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

-(void)addRefresh{
    [self addRefresh:YES pull_up:YES];
}


-(void)delRefresh{
    _tableView.mj_header = nil;
    _tableView.mj_footer= nil;
}

-(void)rereshing:(BOOL)header{}

/**
 添加刷新方式
 @param drop_down 下拉刷新 YES
 @param pull_up 上拉加载
 */
-(void)addRefresh:(BOOL)drop_down pull_up:(BOOL)pull_up{
    WS(weakSelf);
    if(drop_down)  {
        //下拉刷新
        MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf rereshing:YES];
            [weakSelf.tableView.mj_header endRefreshing];
        }];
        //设置自定义文字，因为默认是英文的
        [header setTitle:@"下拉刷新"forState:MJRefreshStateIdle];
        [header setTitle:@"松开加载更多"forState:MJRefreshStatePulling];
        [header setTitle:@"正在刷新中......"forState:MJRefreshStateRefreshing];
        self.tableView.mj_header = header;
    }
    
    //上拉刷新
    if(pull_up){
        
        MJRefreshBackNormalFooter * foot =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf rereshing:NO];
            [weakSelf.tableView.mj_footer endRefreshing];
        }];
        [foot setTitle:@"上拉刷新"forState:MJRefreshStateIdle];
        [foot setTitle:@"松开加载更多"forState:MJRefreshStatePulling];
        [foot setTitle:@"正在刷新中......"forState:MJRefreshStateRefreshing];
        [foot setTitle:@"---------已经到底了---------" forState:MJRefreshStateNoMoreData];
        
        self.tableView.mj_footer= foot;
    }
}

-(void)stopRefreshing {
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [@[] mutableCopy];
    }
    return _dataSource;
}



@end
