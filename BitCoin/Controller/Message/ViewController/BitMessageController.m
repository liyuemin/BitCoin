//
//  BitMessageController.m
//  BitCoin
//
//  Created by yuemin li on 2017/9/1.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BitMessageController.h"
#import "BitMessageCell.h"
#import "BitMessageViewModel.h"
#import "MSLoadingView.h"
#import "MJRefreshNormalHeader.h"

@interface BitMessageController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *listView;
@property (nonatomic ,strong)NSMutableArray *listArray;
@property (nonatomic ,strong)BitMessageViewModel *messageViewModel;
@property (nonatomic ,strong)MSLoadingView *loadingView;
@end

@implementation BitMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navBar.topItem setTitle:@"消息"];
    [self.view addSubview:self.listView];
    [self setViewModelCallBack];
    [self requesMessage:1];
    [self.view addSubview:self.loadingView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requesMessage:(NSInteger)page{
    [self.HUD showAnimated:YES];
    [self.messageViewModel reqeustMessageData:@[[NSString getDeviceIDInKeychain],@"1"] net:YES];
}

- (void)setViewModelCallBack{
    @weakify(self)
    [self.messageViewModel setBlockWithReturnBlock:^(id returnParam, id extroInfo) {
        @strongify(self)
        if (!self)
        {
            return;
        }
        [self.HUD hideAnimated:YES];
        [self.listView.mj_header endRefreshing];
        if ([[extroInfo valueForKey:API_Back_URLCode] rangeOfString:API_BitMessage_Code].location != NSNotFound){
            self.listArray = [BitMessageEntity mj_objectArrayWithKeyValuesArray:returnParam];
            if (self.listArray.count > 0){
                [self.listView reloadData];
            }else {
                [self setLoadingType];
            }
            NSLog(@"%@",returnParam);
        }
    } WithErrorBlock:^(id errorCode, id extroInfo) {
        @strongify(self)
        if (!self)
        {
            return;
        }
        [self.HUD hideAnimated:YES];
        [self.listView.mj_header endRefreshing];
        if ([[extroInfo valueForKey:API_Back_URLCode] rangeOfString:API_BitMessage_Code].location != NSNotFound){
            [self setLoadingType];
            
        }
    } WithFailureBlock:^(id retrunParam, id extroInfo) {
        @strongify(self)
        if (!self)
        {
            return;
        }
        [self.HUD hideAnimated:YES];
        [self.listView.mj_header endRefreshing];
        [self showAlertToast:@"请求网络失败"];
    }];

}

- (void)setLoadingType{
    self.loadingView.hidden = NO;
    self.loadingView.noResultType = MSNoResultSysMsgListType;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"messageIdentifier";
    BitMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[BitMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setMessageCellData:[self.listArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)headerWithRefreshing{
   [self requesMessage:1];
}

- (UITableView *)listView {
    if(!_listView){
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        [_listView setDelegate:self];
        [_listView setDataSource:self];
        _listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerWithRefreshing)];
    }
    return _listView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSMutableArray *)listArray{
    if (!_listArray){
        _listArray = [[NSMutableArray alloc] init];
    }
    return _listArray;
}

-(BitMessageViewModel *)messageViewModel{
    if (!_messageViewModel){
        _messageViewModel = [[BitMessageViewModel alloc] init];
    }
    return _messageViewModel;
}

- (MSLoadingView *)loadingView{
    if (!_loadingView){
        _loadingView = [[MSLoadingView alloc]initWithFrame:CGRectMake(0, 64,ScreenWidth, ScreenHeight - 64)];
        _loadingView.hidden = YES;

    }
    return _loadingView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
