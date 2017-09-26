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
#import "BitFeatureView.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,BHomeCellDelegate,MSLoadingViewDelegate,BitFeatureViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)HMSegmentedControl *segmentedControl;
@property (nonatomic ,strong)BHomeViewModel *homeViewModel;
@property (nonatomic ,strong)NSMutableDictionary *bitData;
@property (nonatomic ,strong)NSArray *bitClassData;
@property (nonatomic , strong)dispatch_source_t timer;
@property (nonatomic ,strong)NSMutableDictionary *requstTimeData;
@property(nonatomic,strong)MSLoadingView * loadingView;
@property (nonatomic ,strong)BitFeatureView *featureView;
@end

@implementation ViewController

- (void)viewDidLoad {
    self.haveMyNavBar = YES;
    self.noMyNavBarBackBtn = YES;
    [super viewDidLoad];
    //[self setMySatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupViews];
    [self setViewModle];
    [self requestHttp];
   // [self setDesplayTimer];
    [self.view addSubview:self.loadingView];
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _featureView = [[BitFeatureView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [_featureView.bgImageView setImage:[UIImage imageNamed:@"lunchScreen"]];
    [window addSubview:_featureView];
    [_featureView setDelegate:self];
    [self performSelector:@selector(removeBgView) withObject:nil afterDelay:1];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotification:) name:@"pushnotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gomMessage:) name:@"pushViewController" object:nil];

}



- (void)removeBgView{
    if (_featureView){
        [_featureView.bgImageView removeFromSuperview];
        NSArray *featureData = [KUserdefaults objectForKey:@"appStartData"];
        if (featureData.count > 2){
            [_featureView setFeatureData:[BitEnity mj_objectArrayWithKeyValuesArray:featureData]];
        } else {
            [_featureView removeFromSuperview];
        }
    }
}

- (void)removeFeatureView:(BitFeatureView *)featrue {
    if (_featureView){
        [UIView animateWithDuration:.2 animations:^{
            [_featureView setCenter:CGPointMake(- ScreenWidth/2, ScreenHeight/2)];
        } completion:^(BOOL finish){
            [_featureView removeFromSuperview];
            _featureView = nil;

        }];
    }
}

- (void)setupViews {
    
    //UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 80, 44)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"home_navi_icon"] forState:UIControlStateNormal];
    [button setTitle:@"BitCoin金融圈" forState:UIControlStateNormal];
    [button setTitleColor:k_FAFAFA forState:UIControlStateNormal];
    [button.titleLabel setFont:SYS_FONT(18)];
    [button sizeToFit];
    [button setCenter:CGPointMake(self.navBar.center.x, self.navBar.center.y +10)];
    [self.navBar addSubview:button];
    
    UIButton * rightBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBnt setImage:[UIImage imageNamed:@"home_search_icon"] forState:UIControlStateNormal];
    [rightBnt setBackgroundColor:[UIColor redColor]];
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.bitClassData.count > 0){
        [self requestBitType:[(BitClassEntity *)[self.bitClassData objectAtIndex:0] val] page:1 withLoad:NO withRefrensh:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushNotification:(NSNotification *)notification {
    UIButton *button = (UIButton *)[self.navBar.topItem.leftBarButtonItem customView];
    [button pp_showBadge];
}

- (void)setSegmentedData{
    NSMutableArray *bittypArray = [[NSMutableArray alloc] init];
    int hotIndex = -1;
    for(int i = 0 ; i < self.bitClassData.count ; i++){
        BitClassEntity *entity = [self.bitClassData objectAtIndex:i];

        if ([entity.tag isEqualToString:@"hot"]){
            hotIndex = i;
        }
        [bittypArray addObject:entity.title];
    }
    if (hotIndex >= 0){
        [self.segmentedControl setBadgeImage:[UIImage imageNamed:@"home_hot_cion"]];
        [self.segmentedControl setBadgeIndex:hotIndex];
    }
    [self.segmentedControl setSectionTitles:bittypArray];
    [self segmentedControlChangedValue:self.segmentedControl];
}

- (void)requestHttp{
    [self.HUD showAnimated:YES];
    [self.homeViewModel requestBitClassInfoListWithNet:YES];
}

- (void)requestBitType:(NSString *)type page:(int)page withLoad:(BOOL)load withRefrensh:(BOOL)refresh{
    NSDate *oldDate = [self.requstTimeData objectForKey:type];
    NSDate *date = [NSDate date];
    if (refresh){
        if (load){
            [self.HUD showAnimated:YES];
        }
        [self.requstTimeData setObject:[NSDate date] forKey:type];
        [self.homeViewModel requesBitHomeList:@[[NSString getDeviceIDInKeychain],type,@"1"] withKey:type net:YES];

    } else {
        NSArray *array = [self.bitData objectForKey:type];
        if (labs([date second] - [oldDate second]) > 10 || array.count == 0 ){
            if (load){
                [self.HUD showAnimated:YES];
            }
            [self.requstTimeData setObject:[NSDate date] forKey:type];
            [self.homeViewModel requesBitHomeList:@[[NSString getDeviceIDInKeychain],type,@"1"] withKey:type net:YES];
        } else {
            [self endRefreshing:type];
        }
    }
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
    NSTimeInterval period = 12.0;//设置时间间隔
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, period * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    @weakify(self)
    
    dispatch_source_set_event_handler(_timer, ^{
        
        NSLog(@"%@" , [NSThread currentThread]);//打印当前线程
        
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            if (self.bitClassData.count > 0){
                [self requestBitType:[(BitClassEntity *)[self.bitClassData objectAtIndex:self.segmentedControl.selectedSegmentIndex] val] page:1 withLoad:NO withRefrensh:NO];
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
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.segmentedControl.selectedSegmentIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            //[self.tableView reloadData];
        }else if ([[extroInfo valueForKey:API_Back_URLCode] isEqualToString:API_BitClassInfo_Code]){
            self.loadingView.hidden = YES;
            self.bitClassData = [BitClassEntity mj_objectArrayWithKeyValuesArray:returnParam];
            [self.tableView reloadData];
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
        NSString *requestSring = [extroInfo valueForKey:API_Back_URLCode];
        NSString *key = [extroInfo valueForKey:API_Back_ExtroInfo];
        if ([requestSring rangeOfString:API_BitHomeList_Code].location != NSNotFound && key != nil){
            ApiError *error = (ApiError *)retrunParam;
            if (error.statusCode == 400){
                [self.tableView reloadData];
            }

        }
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
    [searchVc setNavBarColor:k_FAFAFA];
    [searchVc setHaveMyNavBar:YES];
    [searchVc setLineBool:YES];
    [self.navigationController pushViewController:searchVc animated:YES];

}

- (void)gomMessage:(id)sender{
    UIButton *button = (UIButton *)[self.navBar.topItem.leftBarButtonItem customView];
    [button pp_hiddenBadge];
    BitMessageController *messageVC = [[BitMessageController alloc] init];
    [messageVC setNavBarColor:k_FAFAFA];
    [messageVC setBackImageName:@"nav_back_one"];
    [messageVC setLineBool:YES];
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
    
    [UIView animateWithDuration:.1 animations:^{
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    } completion:^(BOOL finish){
        
        [self requestBitType:[(BitClassEntity *)[self.bitClassData objectAtIndex:index] val] page:1 withLoad:NO withRefrensh:NO];
    }];
    
    
   // BHomeCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    
}





#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.y / pageWidth;
    if(page != self.segmentedControl.selectedSegmentIndex){
        [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
        [self segmentedControlChangedValue:self.segmentedControl];
    }
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
    [self requestBitType:[(BitClassEntity *)[self.bitClassData objectAtIndex:path.row] val] page:1 withLoad:NO withRefrensh:YES];
}

//- (void)footerReloadData:(BHomeCell *)homecell {
//    NSIndexPath *path = [self.tableView indexPathForCell:homecell];
//    NSString *key = [(BitClassEntity *)[self.bitClassData objectAtIndex:path.row] val];
//    NSString *page = [self.pageData objectForKey:key];
//
//}

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
        _segmentedControl.frame = CGRectMake(0, 66, ScreenWidth, 40);
        _segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _segmentedControl.selectionIndicatorHeight = 2.0f;
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        //[_segmentedControl setSegmentWidthStyle:HMSegmentedControlSegmentWidthStyleDynamic];
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
        _tableView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight-106);
        _tableView.allowsSelection = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if(@available(iOS 11.0, *)){
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);//导航栏如果使用系统原生半透明的，top设置为64
            _tableView.scrollIndicatorInsets = _tableView.contentInset;

        }else {


        }
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
        [_loadingView setReloadImage:@"refrensh_button_cion"];
        [_loadingView setNetworkImage:@"network_Icon"];
        _loadingView.delegate = self;
    }
    return _loadingView;
}



@end
