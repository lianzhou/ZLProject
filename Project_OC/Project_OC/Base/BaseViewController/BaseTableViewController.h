//
//  BaseTableViewController.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/14.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, assign) NSString  *totalCount;


/** 刷新方式返回  header YES 下拉刷新 */
-(void)rereshing:(BOOL)header;

/** 下拉/上拉 刷新 */
-(void)addRefresh;
-(void)delRefresh;
-(void)stopRefreshing;

/** 添加刷新方式  drop_down 下拉刷新 YES  pull_up 上拉加载 */
-(void)addRefresh:(BOOL)drop_down pull_up:(BOOL)pull_up;

@end

NS_ASSUME_NONNULL_END
