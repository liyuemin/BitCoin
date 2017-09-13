//
//  BDetailsController.m
//  BitCoin
//
//  Created by yuemin li on 2017/8/23.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BDetailsController.h"
#import "BitDetailsViewModel.h"
#import "BitDetailsEntity.h"
#import "BitDetailsPriceEntity.h"
//#import "BitDetailsCell.h"
//#import "BitLineChartCell.h"
#import "BitDetailsTextCell.h"
#import "BitDetailsWebCell.h"
#import "BitWebController.h"
#import "BitDetailsLasterPriceEntity.h"
#import "NSString+AFNetWorkAdditions.h"
#import "BitDetailsHeaderView.h"

@interface BDetailsController ()<UITableViewDelegate ,UITableViewDataSource,BitDetailsHeaderViewDelegate>
@property (nonatomic ,strong)BitDetailsViewModel *detailsViewModel;
@property (nonatomic ,strong)BitDetailsEntity*detailsEntity;
@property (nonatomic ,strong)NSMutableDictionary *pricData;
@property (nonatomic ,strong)UITableView *listView;
@property (nonatomic ,strong)NSMutableArray *webArray;
@property (nonatomic ,copy)NSString *requestKey;
@property (nonatomic ,strong)BitDetailsPriceEntity *priceEntity;
@property (nonatomic ,strong)BitDetailsLasterPriceEntity *lasterPriceEntity;
@property (nonatomic , strong)dispatch_source_t timer;
@property (nonatomic ,strong)BitDetailsHeaderView *tableHeaderView;
@end

@implementation BDetailsController
@synthesize bitId;

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navBar.topItem setTitle:self.navititle];
    [self setUpViews];
    [self setViewModelBlock];
    [self requestDeltailsBitId:self.bitId];
    self.requestKey = @"minute";
    [self requesPricebitId:self.bitId withtype:@"minute"];
   
    [self performSelector:@selector(setDesplayTimer)withObject:nil afterDelay:5];
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self stopTimer];
}

- (void)dealloc{
    [self stopTimer];
}

- (void)setUpViews{
    [self.view addSubview:self.listView];
    _tableHeaderView = [[BitDetailsHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 370)];
    [_tableHeaderView setDelegate:self];
    [self.listView setTableHeaderView:_tableHeaderView];

}

- (void)requestDeltailsBitId:(NSString *)bitid{
    [self.HUD showAnimated:YES];
    [self.detailsViewModel requesBitDetailsWithId:@[bitid,[NSString getDeviceIDInKeychain]] net:YES];
}

- (void)requesPricebitId:(NSString *)bitid  withtype:(NSString *)date{
    [self.detailsViewModel requestBitPrice:@[bitid,date] withkey:date net:YES];
}

- (void)requestLasterPrice:(NSString *)bitid withKey:(NSString *)key{
    [self.detailsViewModel requestLasterPrice:@[bitid,key] withKey:key withNet:YES];
}

- (void)setDesplayTimer{
    NSTimeInterval period = 5.0;//设置时间间隔
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
   
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, period * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(_timer, ^{
        
        NSLog(@"%@" , [NSThread currentThread]);//打印当前线程
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self requestLasterPrice:self.bitId withKey:self.requestKey];
        });
        
    });
    
    dispatch_resume(_timer);
    
}

- (void)stopTimer{
    if (_timer){
         dispatch_source_cancel(_timer);
        _timer = nil;
    }
}


- (void)setViewModelBlock{
    @weakify(self)
    [self.detailsViewModel setBlockWithReturnBlock:^(id returnParam, id extroInfo) {
        @strongify(self)
        if (!self)
        {
            return;
        }
        [self.HUD hideAnimated:YES];
          if ([[extroInfo valueForKey:API_Back_URLCode] rangeOfString:API_BitDetail_Code].location != NSNotFound){
              NSDictionary *entityData =  returnParam[@"detail"];
              self.detailsEntity = [BitDetailsEntity mj_objectWithKeyValues:entityData];
              self.webArray = [BitPlatformEntity mj_objectArrayWithKeyValuesArray:entityData[@"btc_detail_kv"]];
              
              [self.tableHeaderView setDetailCellData:self.detailsEntity];
              
              
              [self.listView reloadData];
          } else if ([[extroInfo valueForKey:API_Back_URLCode] rangeOfString:API_BitPrice_Code].location != NSNotFound){
              NSString *key = [extroInfo valueForKey:API_Back_ExtroInfo];
              if ([self.requestKey isEqualToString:key]){
                  if ([self.pricData allKeys].count > 0){
                      [self.pricData removeAllObjects];
                  }
                  NSArray *array  = [BitDetailsPriceEntity mj_objectArrayWithKeyValuesArray:returnParam];
                  [self.pricData setObject:array forKey:key];
                  
                  [self.tableHeaderView setBitLineData:[self.pricData valueForKey:self.requestKey] withKey:self.requestKey withLaster:self.priceEntity];
              }

          }else if ([[extroInfo valueForKey:API_Back_URLCode] isEqualToString:API_BitFollow_Code]){
              NSDictionary *info =  [extroInfo valueForKey:API_Back_ExtroInfo];
              BitDetailsEntity *entity = [info valueForKey:@"btc"];
              if (entity){
                  [entity setIs_follow:YES];
              }
              //self.followBlock(YES);
              [self showAlertToast:@"关注成功"];
              [self.tableHeaderView setDetailCellData:entity];
          }
          else if ([[extroInfo valueForKey:API_Back_URLCode] rangeOfString:API_BitUnFollow_Code].location != NSNotFound){
              NSDictionary *info =  [extroInfo valueForKey:API_Back_ExtroInfo];
              BitDetailsEntity *entity = [info valueForKey:@"btc"];
              if (entity){
                  [entity setIs_follow:NO];
              }
              //self.followBlock(YES);
              [self showAlertToast:@"取消关注成功"];
              [self.tableHeaderView setDetailCellData:entity];
          } else if ([[extroInfo valueForKey:API_Back_URLCode] rangeOfString:API_BitLaster_Code].location != NSNotFound){
              self.lasterPriceEntity = [BitDetailsLasterPriceEntity mj_objectWithKeyValues:returnParam[@"info"]];
              if (self.lasterPriceEntity){
                  [self.detailsEntity setRising:self.lasterPriceEntity.rising];
                  [self.detailsEntity setTrading:self.lasterPriceEntity.trading];
                  [self.detailsEntity setBtc_price:self.lasterPriceEntity.btc_price];
                  [self.detailsEntity setRising_val:self.lasterPriceEntity.rising_val];
                  BitDetailsPriceEntity *price = [[BitDetailsPriceEntity alloc] init];
                  price.btc_price = self.detailsEntity.btc_price;
                  price.create_time = [NSString stringWithFormat:@"%lld",(long long int)[[NSDate date] timeIntervalSince1970]];
                  self.priceEntity = price;
                  
              }
              [self.tableHeaderView setDetailCellData:self.detailsEntity];
              [self.tableHeaderView setBitLineData:[self.pricData valueForKey:self.requestKey] withKey:self.requestKey withLaster:self.priceEntity];
          }
    } WithErrorBlock:^(id errorCode, id extroInfo) {
        @strongify(self)
        if (!self)
        {
            return;
        }
        [self.HUD hideAnimated:YES];
        if ([[extroInfo valueForKey:API_Back_URLCode] isEqualToString:API_BitFollow_Code]){
           [self showAlertToast:@"关注失败"];
        }else if([[extroInfo valueForKey:API_Back_URLCode] rangeOfString:API_BitUnFollow_Code].location != NSNotFound){
           [self showAlertToast:@"取消关注失败"];
        }
    } WithFailureBlock:^(id retrunParam, id extroInfo) {
        @strongify(self)
        if (!self)
        {
            return;
        }
        [self.HUD hideAnimated:YES];
        if ([[extroInfo valueForKey:API_Back_URLCode] isEqualToString:API_BitFollow_Code]){
            [self showAlertToast:@"关注失败"];
        }else if([[extroInfo valueForKey:API_Back_URLCode] rangeOfString:API_BitUnFollow_Code].location != NSNotFound){
            [self showAlertToast:@"取消关注失败"];
        }

    }];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.detailsEntity != nil){
        return 1 + self.webArray.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (indexPath.row == 0){
       static NSString *textIdentifier = @"textIdentifier";
        BitDetailsTextCell *cell = [tableView dequeueReusableCellWithIdentifier:textIdentifier];
        if (!cell){
            cell = [[BitDetailsTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        [cell.titleLabel setText:@"币种介绍"];
        [cell.destailLabe setText:self.detailsEntity.btc_desc];
        return cell;
    }else {
        static NSString *webIdentifier = @"webIdentifier";
        BitDetailsWebCell *cell = [tableView dequeueReusableCellWithIdentifier:webIdentifier];
        if (!cell){
            cell = [[BitDetailsWebCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:webIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        BitPlatformEntity *entity = [self.webArray objectAtIndex:indexPath.row-1];
        [cell setWebCellData:entity];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        return 80 + [self.detailsEntity.btc_desc boundingRectWithSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
    } else {
        BitPlatformEntity *entity = [self.webArray objectAtIndex:indexPath.row-1];
        
        return 20 + [entity.v boundingRectWithSize:CGSizeMake(ScreenWidth - 250, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= 1){
        BitPlatformEntity *entity = [self.webArray objectAtIndex:indexPath.row-1];
        if ([entity.v isValidUrl]){
            BitWebController *webController = [[BitWebController alloc] init];
            [webController setHaveMyNavBar:YES];
            [webController setWebUrlString:entity.v];
            [self.navigationController pushViewController:webController animated:YES];
        }
    }
 }

-(void)tableView:(UITableView* )tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 1){
        [cell setBackgroundColor:indexPath.row%2 != 0 ? k_FAFAFA : [UIColor whiteColor]];
    }
}


- (void)selectSegmentIndex:(NSInteger)index withKey:(NSString *)key {
    self.requestKey = [key copy];
    [self requesPricebitId:self.bitId withtype:key];
}


- (void)selectDetailsHeader:(BitDetailsHeaderView *)header withFollow:(BOOL)follow {
    if (follow){
        [self.detailsViewModel requestFollow:@{@"device_id":[NSString getDeviceIDInKeychain],@"btc_id":self.detailsEntity.btc_id} withBackParam:@{@"btc":self.detailsEntity} withNet:YES];
    }else {
        [self.detailsViewModel requestUnFollow:@[[NSString getDeviceIDInKeychain],self.detailsEntity.btc_id] withBackParam:@{@"btc":self.detailsEntity} withNet:YES];
    }

}




- (BitDetailsViewModel *)detailsViewModel {
    if (!_detailsViewModel){
        _detailsViewModel = [[BitDetailsViewModel alloc] init];
    }
    return _detailsViewModel;
}

- (NSMutableDictionary *)pricData {
    if (!_pricData){
        _pricData = [[NSMutableDictionary alloc] init];
    }
    return _pricData;
}



- (UITableView *)listView {
    if (!_listView){
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
        [_listView setDelegate:self];
        [_listView setSeparatorColor:[UIColor clearColor]];
        [_listView setDataSource:self];
    }
    return _listView;
}

- (NSMutableArray *)webArray{
    if (!_webArray){
        _webArray = [[NSMutableArray alloc] init];
    }
    return _webArray;
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
