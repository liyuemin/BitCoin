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

@interface BHomeCell()<UITableViewDelegate,UITableViewDataSource,MSLoadingViewDelegate,BFollowCellDelegate>

@property (nonatomic ,strong)UITableView *cellTable;
@property (nonatomic ,strong)NSArray *data;
@property (nonatomic ,assign)NSInteger currenIndex;
@property (nonatomic,strong)MSLoadingView * loadingView;
@property (nonatomic ,strong)NSMutableDictionary *pathData;
@property (nonatomic ,assign)BOOL is_Refreshing;
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
    
    if (index == 0 && array.count == 0){
        if (_loadingView == nil){
            [self.contentView addSubview:self.loadingView];
        }
        [_loadingView setHidden:NO];
    }else {
        [_loadingView setHidden:YES];
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
    self.is_Refreshing = YES;
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
        [cell setDelegate:self];
    }
    BOOL display = [[self.pathData objectForKey:[NSString stringWithFormat:@"%ld",self.currenIndex]] boolValue];
    [cell setFollowData:[self.data objectAtIndex:indexPath.row] withDisPlay:display withAnimation:self.is_Refreshing];
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
    BitHomeHeaderView *headerView = [[BitHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 41)];
    [headerView setBackgroundColor:k_EFEFF4];
    [headerView.titleLabel setText:@"名称"];
    [headerView.priceLabel setText:@"当前价"];
    BOOL display = [[self.pathData objectForKey:[NSString stringWithFormat:@"%ld",self.currenIndex]] boolValue];
    if (display){
        [headerView.roseLabel setText:@"交易量"];
    }else {
        [headerView.roseLabel setText:@"涨跌幅"];
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.data.count > 0){
        return 41;
    }
    return 0;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.currenIndex == 0  && self.data.count < 5 && self.data.count > 0){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90)];
        UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 80)];
        [aview setBackgroundColor:[UIColor whiteColor]];
        [footerView addSubview:aview];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setFrame:CGRectMake(0, 10, ScreenWidth, 40)];
        [button setImage:[UIImage imageNamed:@"search_footerfollow_icon"] forState:UIControlStateNormal];
        [button setTitle:@"添加币种" forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [button setTitleColor:k_9596AB forState:UIControlStateNormal];
        [button addTarget:self action:@selector(searchBit:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *alabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, 20)];
        [alabel setBackgroundColor:[UIColor whiteColor]];
        [alabel setText:@"体验智能预警超强功能"];
        [alabel setTextColor:k_999999];
        [alabel setFont:SYS_FONT(12)];
        [alabel setTextAlignment:NSTextAlignmentCenter];
        [aview addSubview:alabel];
        [aview addSubview:button];
        
        return footerView;
        
    }
    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.currenIndex == 0 && self.data.count < 5){
        return 80;
    }
    
    return 0;
}
-(void)tableView:(UITableView* )tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        //end of loading
        dispatch_async(dispatch_get_main_queue(),^{
            self.is_Refreshing = NO;
        });
    }

}


- (void)msLoadingRetryAction {
    if (_delegate && [_delegate respondsToSelector:@selector(addBitFollow)]){
        [_delegate addBitFollow];
    }
}

- (void)didSelect:(BFollowCell *)cell withDisPlay:(BOOL)display {
     [self.pathData setObject:[NSNumber numberWithBool:display] forKey:[NSString stringWithFormat:@"%ld",self.currenIndex]];
    [self.cellTable reloadData];
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
        [_cellTable setBackgroundColor:k_EFEFF4];
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

- (NSMutableDictionary *)pathData{
    if (!_pathData){
        _pathData = [[NSMutableDictionary alloc] init];
    }
    return _pathData;
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
