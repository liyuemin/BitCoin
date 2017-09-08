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
#import "BitDetailsCell.h"
#import "BitLineChartCell.h"
#import "BitDetailsTextCell.h"
#import "BitDetailsWebCell.h"
#import "BitWebController.h"
#import "BitPlatformEntity.h"

@interface BDetailsController ()<UITableViewDelegate ,UITableViewDataSource,BitLineChartCellDelegate,BitDetailsCellDelegate>
@property (nonatomic ,strong)BitDetailsViewModel *detailsViewModel;
@property (nonatomic ,strong)BitDetailsEntity*detailsEntity;
@property (nonatomic ,strong)NSMutableDictionary *pricData;
@property (nonatomic ,strong)UITableView *listView;
@property (nonatomic ,strong)NSMutableArray *webArray;
@property (nonatomic ,copy)NSString *requestKey;
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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpViews{
    [self.view addSubview:self.listView];
}

- (void)requestDeltailsBitId:(NSString *)bitid{
    [self.HUD showAnimated:YES];
    [self.detailsViewModel requesBitDetailsWithId:bitid net:YES];
}

- (void)requesPricebitId:(NSString *)bitid  withtype:(NSString *)date{
    [self.detailsViewModel requestBitPrice:@[bitid,date] withkey:date net:YES];
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
        NSString *urlSring = [NSString stringWithFormat:@"%@%@",API_BitDetail_Code,self.bitId];
          if ([[extroInfo valueForKey:API_Back_URLCode] isEqualToString:urlSring]){
              NSDictionary *entityData =  returnParam[@"detail"];
              self.detailsEntity = [BitDetailsEntity mj_objectWithKeyValues:entityData];
              [self.detailsEntity setIs_follow:self.isfollow];
              self.webArray = [BitPlatformEntity mj_objectArrayWithKeyValuesArray:entityData[@"btc_detail_kv"]];
              [self.listView reloadData];
          } else if ([[extroInfo valueForKey:API_Back_URLCode] rangeOfString:API_BitPrice_Code].location != NSNotFound){
              NSString *key = [extroInfo valueForKey:API_Back_ExtroInfo];
              if ([self.requestKey isEqualToString:key]){
                  if ([self.pricData allKeys].count > 0){
                      [self.pricData removeAllObjects];
                  }
                  NSArray *array  = [BitDetailsPriceEntity mj_objectArrayWithKeyValuesArray:returnParam];
                  [self.pricData setObject:array forKey:key];
                  [self.listView reloadData];
              }

          }else if ([[extroInfo valueForKey:API_Back_URLCode] isEqualToString:API_BitFollow_Code]){
              NSDictionary *info =  [extroInfo valueForKey:API_Back_ExtroInfo];
              BitDetailsEntity *entity = [info valueForKey:@"btc"];
              if (entity){
                  [entity setIs_follow:YES];
              }
              //self.followBlock(YES);
              [self showAlertToast:@"关注成功"];
              [self.listView reloadData];
          }
          else if ([[extroInfo valueForKey:API_Back_URLCode] rangeOfString:API_BitUnFollow_Code].location != NSNotFound){
              NSDictionary *info =  [extroInfo valueForKey:API_Back_ExtroInfo];
              BitDetailsEntity *entity = [info valueForKey:@"btc"];
              if (entity){
                  [entity setIs_follow:NO];
              }
              //self.followBlock(YES);
              [self showAlertToast:@"取消关注成功"];
              [self.listView reloadData];
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
        return 3 + self.webArray.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
       static NSString *followIdentifier = @"followIdentifier";
        BitDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:followIdentifier];
        if (!cell){
            cell = [[BitDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:followIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setDelegate:self];
        }
        [cell setDetailCellData:self.detailsEntity];
        return cell;
    }else if (indexPath.row == 1){
        static NSString *linechareIdentifier = @"linechareIdentifier";
        BitLineChartCell *cell = [tableView dequeueReusableCellWithIdentifier:linechareIdentifier];
        if (!cell){
            cell = [[BitLineChartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:linechareIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setDelegate:self];
        }
        [cell setBitLineData:[self.pricData valueForKey:self.requestKey] withKey:self.requestKey];
        return cell;
        
    }else if (indexPath.row == 2){
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
        if (indexPath.row == 3){
            [cell.titleLabel setText:@"官网"];
        }else {
           [cell.titleLabel setText:@"交易地址"];
        }
        BitPlatformEntity *entity = [self.webArray objectAtIndex:indexPath.row-3];
        [cell.titleLabel setText:entity.k];
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:entity.v];
        NSRange contentRange = {0,[content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        [cell.webLabel setAttributedText:content];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        return 130;
    }else if (indexPath.row == 1){
        return 240;
    }else if (indexPath.row == 2){
        return 80 + [self.detailsEntity.btc_desc boundingRectWithSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
    } else {
        return 60;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= 3){
        NSString *urlsring =  nil;
        if (indexPath.row == 3){
            urlsring = [[self.webArray objectAtIndex:0] copy];
        }else {
            urlsring = [[self.webArray objectAtIndex:1] copy];
        }
        BitWebController *webController = [[BitWebController alloc] init];
        [webController setHaveMyNavBar:YES];
        [webController setWebUrlString:urlsring];
        [self.navigationController pushViewController:webController animated:YES];
    }
}

- (void)selectSegmentIndex:(NSInteger)index withKey:(NSString *)key {
    self.requestKey = [key copy];
    [self requesPricebitId:self.bitId withtype:key];
}


- (void)selectDetailsCell:(BitDetailsCell *)cell withFollow:(BOOL)follow {
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
