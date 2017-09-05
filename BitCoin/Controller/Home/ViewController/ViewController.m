//
//  ViewController.m
//  BitCoin
//
//  Created by yuemin li on 2017/8/21.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "ViewController.h"
#import "HMSegmentedControl.h"
#import "BHomeCell.h"
#import "BSearchViewController.h"
#import "BDetailsController.h"
#import "BHomeViewModel.h"
#import "NSString+AFNetWorkAdditions.h"
#import "BitEnity.h"
#import "BitClassEntity.h"
#import "PPBadgeView.h"
#import "BitMessageController.h"
#import "NSDate+YYAdd.h"
#import "MSLoadingView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,BHomeCellDelegate,MSLoadingViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)HMSegmentedControl *segmentedControl;
@property (nonatomic ,strong)BHomeViewModel *homeViewModel;
@property (nonatomic ,strong)NSMutableDictionary *bitData;
@property (nonatomic ,strong)NSArray *bitClassData;
@property (nonatomic , strong)dispatch_source_t timer;
@property (nonatomic ,strong)NSMutableDictionary *requstTimeData;
@property(nonatomic,strong)MSLoadingView * loadingView;
@end

@implementation ViewController

- (void)viewDidLoad {
    self.haveMyNavBar = YES;
    [super viewDidLoad];
    [self setupViews];
    [self setViewModle];
    [self requestHttp];
    [self setDesplayTimer];
    [self.view addSubview:self.loadingView];
}

- (void)setupViews {
    
    //UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 80, 44)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"home_navi_icon"] forState:UIControlStateNormal];
    [button setTitle:@"BitCoin金融圈" forState:UIControlStateNormal];
    [button setTitleColor:k_FAFAFA forState:UIControlStateNormal];
    [button.titleLabel setFont:SYS_FONT(18)];
    [button sizeToFit];
    [button setCenter:self.navBar.center];
    //[titleView addSubview:button];
    [self.navBar addSubview:button];
    
    UIButton * rightBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBnt setImage:[UIImage imageNamed:@"home_search_icon"] forState:UIControlStateNormal];
    [rightBnt addTarget:self action:@selector(searchBit:) forControlEvents:UIControlEventTouchUpInside];
    [rightBnt sizeToFit];
    UIBarButtonItem * rightBntItem = [[UIBarButtonItem alloc]initWithCustomView:rightBnt];
    self.navBar.topItem.rightBarButtonItem = rightBntItem;
    
    UIButton * LeftBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    [LeftBnt setImage:[UIImage imageNamed:@"home_message_icon"] forState:UIControlStateNormal];
    [LeftBnt sizeToFit];
    [LeftBnt addTarget:self action:@selector(gomMessage:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBntItem = [[UIBarButtonItem alloc]initWithCustomView:LeftBnt];
    self.navBar.topItem.leftBarButtonItem = leftBntItem;
    [LeftBnt pp_addDotWithColor:nil];
    
    
    [self.view addSubview:self.segmentedControl];
    
    [self.view addSubview:self.tableView];
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSegmentedData{
    NSMutableArray *bittypArray = [[NSMutableArray alloc] init];
    for(BitClassEntity *entity in self.bitClassData){
        [bittypArray addObject:entity.title];
    }
    [self.segmentedControl setBadgeImage:[UIImage imageNamed:@"home_hot_cion"]];
    [self.segmentedControl setBadgeIndex:2];
    [self.segmentedControl setSectionTitles:bittypArray];
    [self.tableView reloadData];
    [self segmentedControlChangedValue:self.segmentedControl];
}

- (void)requestHttp{
    [self.HUD showAnimated:YES];
    [self.homeViewModel requestBitClassInfoListWithNet:YES];
}

- (void)requestBitType:(NSString *)type page:(int)page withLoad:(BOOL)load{
    NSDate *oldDate = [self.requstTimeData objectForKey:type];
    NSDate *date = [NSDate date];
    if ([date second] - [oldDate second] > 5){
        if (load){
            [self.HUD showAnimated:YES];
        }
        [self.requstTimeData setObject:[NSDate date] forKey:type];
        
        [self.homeViewModel requesBitHomeList:@[[NSString getDeviceIDInKeychain],type,@"1"] withKey:type net:YES];
    }
}

- (void)headerWithRefreshing{
    NSInteger index = (long)self.segmentedControl.selectedSegmentIndex;
    [self requestBitType:[(BitClassEntity *)[self.bitClassData objectAtIndex:index] val] page:1 withLoad:YES];
  
}

- (void)endRefreshing:(NSString *)key{
    NSInteger dataIndex = NSNotFound;
    for (int i = 0 ; i < self.bitClassData.count ;i++){
        BitClassEntity *entity = [self.bitClassData objectAtIndex:i];
        if ([entity.val isEqualToString:key]){
            dataIndex = i;
            break;
        }
    }
    NSLog(@"----%ld" ,dataIndex);
    if(dataIndex != NSNotFound){
        BHomeCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:dataIndex inSection:0]];
        [cell endRefreshing];
    }

}


- (void)setDesplayTimer{
    NSTimeInterval period = 5.0;//设置时间间隔
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, period * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(_timer, ^{
        
        NSLog(@"%@" , [NSThread currentThread]);//打印当前线程
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.bitClassData.count > 0){
                [self requestBitType:[(BitClassEntity *)[self.bitClassData objectAtIndex:self.segmentedControl.selectedSegmentIndex] val] page:1 withLoad:NO];
            }
        });
        
    });
    
    dispatch_resume(_timer);
    
}

- (void)stopTimer{
    dispatch_source_cancel(_timer);
    _timer = nil;
}

- (void)setViewModle {
    @weakify(self)
    [self.homeViewModel setBlockWithReturnBlock:^(id returnParam, id extroInfo) {
        @strongify(self)
        [self.HUD hideAnimated:YES afterDelay:.3];
        if (!self)
        {
            return;
        }
        NSString *requestSring = [extroInfo valueForKey:API_Back_URLCode];
        NSString *key = [extroInfo valueForKey:API_Back_ExtroInfo];
        if ([requestSring rangeOfString:API_BitHomeList_Code].location != NSNotFound && key != nil){
            NSArray * temArray = [BitEnity mj_objectArrayWithKeyValuesArray:returnParam];
            NSLog(@"%@",temArray);
            [self endRefreshing:key];
            [self.bitData setObject:temArray forKey:key];
            [self.tableView reloadData];
        }else if ([[extroInfo valueForKey:API_Back_URLCode] isEqualToString:API_BitClassInfo_Code]){
            self.loadingView.hidden = YES;
           self.bitClassData = [BitClassEntity mj_objectArrayWithKeyValuesArray:returnParam];
            [self setSegmentedData];
        }
    } WithErrorBlock:^(id errorCode, id extroInfo) {
        @strongify(self)
        [self.HUD hideAnimated:YES afterDelay:.3];
        if (!self)
        {
            return;
        }
        NSString *key = [extroInfo valueForKey:API_Back_ExtroInfo];
         [self endRefreshing:key];
        if ([[extroInfo valueForKey:API_Back_URLCode] isEqualToString:API_BitClassInfo_Code])
        {
            
            self.loadingView.hidden = NO;
            self.loadingView.noResultType = MSNoResultNetType;
        }

    } WithFailureBlock:^(id retrunParam, id extroInfo) {
        @strongify(self)
        [self.HUD hideAnimated:YES afterDelay:.3];
        if (!self)
        {
            return;
        }
        NSString *key = [extroInfo valueForKey:API_Back_ExtroInfo];
         [self endRefreshing:key];
        
        if ([[extroInfo valueForKey:API_Back_URLCode] isEqualToString:API_BitClassInfo_Code])
        {

            self.loadingView.hidden = NO;
            self.loadingView.noResultType = MSNoResultNetType;
        }

    }];
}




- (void)searchBit:(id)sender {
    BSearchViewController *searchVc = [[BSearchViewController alloc] init];
    [searchVc setHaveMyNavBar:YES];
    if (self.bitClassData.count > 0){
         BitClassEntity *entity = [self.bitClassData objectAtIndex:0];
        [searchVc setFollowArray:[self.bitData objectForKey:entity.val]];
    }
    [self.navigationController pushViewController:searchVc animated:YES];

}

- (void)gomMessage:(id)sender{
    BitMessageController *messageVC = [[BitMessageController alloc] init];
    [messageVC setHaveMyNavBar:YES];
    [messageVC setHaveBackBtn:YES];
    [self.navigationController pushViewController:messageVC animated:YES];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bitClassData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"identifer";
    BHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell){
        cell = [[BHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        [cell setDelegate:self];
        
    }
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    BitClassEntity *entity = [self.bitClassData objectAtIndex:indexPath.row];
    [cell loadData:[self.bitData objectForKey:entity.val] withIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScreenWidth;
}



- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    NSInteger index = (long)segmentedControl.selectedSegmentIndex;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    BHomeCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [cell beginRefreshing];
    [self requestBitType:[(BitClassEntity *)[self.bitClassData objectAtIndex:index] val] page:1 withLoad:YES];
    
}





#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.y / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}

- (void)didSelectIndexData:(BitEnity *)entity {
    BDetailsController *detailsVc = [[BDetailsController alloc] init];
    [detailsVc setBitId:entity.btc_id];
    detailsVc.haveMyNavBar = YES;
    [detailsVc setNavititle:entity.btc_title_display];
    [self.navigationController pushViewController:detailsVc animated:YES];
}

- (void)refreshingData:(BHomeCell *)homecell {
    NSIndexPath *path = [self.tableView indexPathForCell:homecell];
    [self requestBitType:[(BitClassEntity *)[self.bitClassData objectAtIndex:path.row] val] page:1 withLoad:YES];
}

- (void)addBitFollow{
    [self searchBit:nil];
}


- (void)msLoadingRetryAction {
    [self requestHttp];
    [self.loadingView setHidden:YES];
}

-(HMSegmentedControl *)segmentedControl{
    if (!_segmentedControl){
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:nil];
        _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        _segmentedControl.frame = CGRectMake(0, 60, ScreenWidth, 40);
        _segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        [_segmentedControl setSelectionIndicatorColor:k_5080D8];
        [_segmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
            NSAttributedString *attString = nil;
            if(selected){
                attString  = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : k_5080D8 ,NSFontAttributeName:SYS_FONT(16)}];
            }else {
                attString  = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : k_999999 ,NSFontAttributeName:SYS_FONT(16)}];
            }
            return attString;
        }];
        [_segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];

    }
    return _segmentedControl;
}


-(UITableView *)tableView{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        [_tableView.layer setAnchorPoint:CGPointMake(0.0, 0.0)];
        _tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        _tableView.dataSource = self;
        _tableView.delegate  = self;
        _tableView.pagingEnabled = YES;
        _tableView.scrollEnabled = YES;
        _tableView.userInteractionEnabled = YES;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight-100);
        _tableView.allowsSelection = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (BHomeViewModel *)homeViewModel {
    if (!_homeViewModel){
        _homeViewModel = [[BHomeViewModel alloc] init];
    }
    return _homeViewModel;
}

- (NSMutableDictionary *)bitData {
    if (!_bitData){
        _bitData = [[NSMutableDictionary alloc] init];
    }
    return _bitData;
}

- (NSArray *)bitClassData {
    if (!_bitClassData){
        _bitClassData = [[NSArray alloc] init];
    }
    return _bitClassData;
}

- (NSMutableDictionary *)requstTimeData{
    if (!_requstTimeData){
        _requstTimeData = [[NSMutableDictionary alloc] init];
    }
    return _requstTimeData;
}

-(MSLoadingView *)loadingView
{
    if (!_loadingView)
    {
        _loadingView = [[MSLoadingView alloc]initWithFrame:CGRectMake(0, 64,ScreenWidth, ScreenHeight - 64)];
        _loadingView.hidden = YES;
        _loadingView.delegate = self;
    }
    return _loadingView;
}


@end
