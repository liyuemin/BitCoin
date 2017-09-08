//
//  BHomeCell.m
//  BitCoin
//
//  Created by yuemin li on 2017/8/23.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BHomeCell.h"
#import "BFollowCell.h"
#import "BitHomeHeaderView.h"
#import "MSLoadingView.h"

@interface BHomeCell()<UITableViewDelegate,UITableViewDataSource,MSLoadingViewDelegate>

@property (nonatomic ,strong)UITableView *cellTable;
@property (nonatomic ,strong)NSArray *data;
@property (nonatomic ,assign)NSInteger currenIndex;
@property(nonatomic,strong)MSLoadingView * loadingView;
@end

@implementation BHomeCell
@synthesize delegate = _delegate;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self.contentView addSubview:self.cellTable];
        [self constraintViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadData:(NSArray *)array withIndex:(NSInteger)index{
    self.data = array;
    self.currenIndex = index;
    if (array != nil){
        if (index == 0 && array.count == 0){
            if (_loadingView == nil){
                  [self.contentView addSubview:self.loadingView];
            }
            [_loadingView setHidden:NO];
        }else {
             [_loadingView setHidden:YES];
        }
    }
    [self.cellTable reloadData];
    
}

-(void)beginRefreshing {
  [self.cellTable.mj_header beginRefreshing];
}

- (void)endRefreshing{
    [self.cellTable.mj_header endRefreshing];
}

- (void)headerWithRefreshing{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(refreshingData:)]){
        [self.delegate refreshingData:self];
    }

}

- (void)constraintViews{
    [self.cellTable mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(self.contentView).offset(0);
        maker.right.mas_equalTo(self.contentView).offset(0);
        maker.top.mas_equalTo(self.contentView).offset(0);
        maker.bottom.mas_equalTo(self.contentView).offset(0);
    }];
}

- (void)searchBit:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(addBitFollow)]){
        [_delegate addBitFollow];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"bfollowIdentifier";
    BFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell){
        cell = [[BFollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        
    }
    [cell setFollowData:[self.data objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectIndexData:)]){
        BitEnity *entity = [self.data objectAtIndex:indexPath.row];
        [_delegate didSelectIndexData:entity];
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BitHomeHeaderView *headerView = [[BitHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    [headerView setBackgroundColor:k_FFFFFF];
    [headerView.titleLabel setText:@"名称"];
    [headerView.priceLabel setText:@"当前价"];
    [headerView.roseLabel setText:@"涨跌幅"];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.currenIndex == 0  && self.data.count < 5){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 72)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, ScreenWidth, 72)];
        [button setImage:[UIImage imageNamed:@"search_footerfollow_icon"] forState:UIControlStateNormal];
        [button setTitle:@"点击添加币种" forState:UIControlStateNormal];
        [button setTitleColor:k_9596AB forState:UIControlStateNormal];
        [button addTarget:self action:@selector(searchBit:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:button];
        
        return footerView;
        
    }
    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.currenIndex == 0 && self.data.count < 5){
        return 72;
    }
    
    return 0;
}
-(void)tableView:(UITableView* )tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
}


- (void)msLoadingRetryAction {
    if (_delegate && [_delegate respondsToSelector:@selector(addBitFollow)]){
        [_delegate addBitFollow];
    }
}



- (UITableView *)cellTable {
    if (!_cellTable){
        _cellTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_cellTable setDelegate:self];
        [_cellTable setDataSource:self];
        [_cellTable setShowsVerticalScrollIndicator:NO];
        [_cellTable setShowsHorizontalScrollIndicator:NO];
        [_cellTable setSeparatorInset:UIEdgeInsetsZero];
        [_cellTable setLayoutMargins:UIEdgeInsetsZero];
        _cellTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerWithRefreshing)];
    }
    return _cellTable;
}
- (NSArray *)data{
    if (!_data){
        _data  =[[NSArray alloc] init];
    }
    return _data;
}
-(MSLoadingView *)loadingView
{
    if (!_loadingView)
    {
        _loadingView = [[MSLoadingView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, ScreenHeight - 64)];
        [_loadingView setReloadImage:@"home_add_follow_cion"];
        [_loadingView setNoResultType:MSNoResultShowreelType];
        _loadingView.hidden = NO;
        _loadingView.delegate = self;
    }
    return _loadingView;
}


@end
