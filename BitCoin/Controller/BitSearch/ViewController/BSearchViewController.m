//
//  BSearchViewController.m
//  BitCoin
//
//  Created by yuemin li on 2017/8/23.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "BSearchViewController.h"
#import "BitSearchViewModel.h"
#import "BitSearchHotWordCell.h"
#import "BitSearchResultCell.h"
#import "BitSearchHotEntity.h"
#import "BDetailsController.h"
#import "BitEnity.h"

@interface BSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,BitSearchResultCellDelegate,BitSearchHotWordCellDelegate>
@property (nonatomic ,strong)UITextField *searchField;
@property (nonatomic ,strong)BitSearchViewModel *searchViewModel;
@property (nonatomic ,strong)UIView *naviView;
@property (nonatomic ,strong)UITableView *listView;
@property (nonatomic ,strong)NSArray *hotArray;
@property (nonatomic ,strong)NSMutableArray *searchArray;
@property (nonatomic ,assign)BOOL isSarch;
@end

@implementation BSearchViewController

- (void)viewDidLoad {
    [self setNoMyNavBarBackBtn:YES];
    [super viewDidLoad];
    [self setMySatusBarStyle:UIStatusBarStyleDefault];
    
    //监听弹出键盘
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillShow:)
     
                                                 name:UIKeyboardWillShowNotification
     
                                               object:nil];
    
    //可以监听收回键盘
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillHide:)
     
                                                 name:UIKeyboardWillHideNotification
     
                                               object:nil];
    
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(15, 27, ScreenWidth-80, 30)];
    [searchView setBackgroundColor:[UIColor whiteColor]];
    [searchView.layer setCornerRadius:2];
    [searchView.layer setBorderWidth:1];
    [searchView.layer setBorderColor:k_E5E5E5.CGColor];
    [searchView setClipsToBounds:YES];
    [searchView addSubview:self.searchField];
    
    UIButton *searchBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBt setImage:[UIImage imageNamed:@"search_search_icon"] forState:UIControlStateNormal];
    [searchBt sizeToFit];
    [searchBt setCenter:CGPointMake(searchBt.center.x + 5, 15)];
    [searchView addSubview:searchBt];
    
    
    UIButton * rightBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBnt setTitle:@"取消" forState:UIControlStateNormal];
    [rightBnt.titleLabel setFont:SYS_FONT(16)];
    [rightBnt setTitleColor:k_5080D8 forState:UIControlStateNormal];
    [rightBnt addTarget:self action:@selector(cancelSearch:) forControlEvents:UIControlEventTouchUpInside];
    [rightBnt sizeToFit];
    UIBarButtonItem * rightBntItem = [[UIBarButtonItem alloc]initWithCustomView:rightBnt];
    self.navBar.topItem.rightBarButtonItem = rightBntItem;
    [self.navBar.topItem.titleView setBackgroundColor:[UIColor blackColor]];
    [self.navBar addSubview:searchView];
    //self.navBar.topItem.titleView = searchView;
    
    [self.view addSubview:self.listView];
    //[self searchBitKeyWork:@"btc"];
    [self setViewModleBlock];
    [self requestSearchHot];

}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.followBlock = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)cancelSearch:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requestSearchHot{
    [self.searchViewModel requestSearchHotNet:YES];
}

- (void)searchBitKeyWork:(NSString *)word {
    [self.searchViewModel requestSearchWithWord:@{@"device_id":[NSString getDeviceIDInKeychain],@"keyword":word} withNet:YES];
    NSLog(@"%@",word);
}


- (void)setViewModleBlock{
    @weakify(self)
    [self.searchViewModel setBlockWithReturnBlock:^(id returnParam, id extroInfo) {
        @strongify(self)
        if (!self)
        {
            return;
        }
        [self.HUD hideAnimated:YES];
        if ([[extroInfo valueForKey:API_Back_URLCode] isEqualToString:API_BitSerach_Code]){
            if (self.searchArray.count > 0){
                [self.searchArray removeAllObjects];
            }
            self.searchArray = [BitSearchResultEntity mj_objectArrayWithKeyValuesArray:returnParam];
            [self.listView reloadData];
        } else if ([[extroInfo valueForKey:API_Back_URLCode] isEqualToString:API_BitSearchHot_Code]){
            self.hotArray = [BitSearchHotEntity mj_objectArrayWithKeyValuesArray:returnParam];
            [self.listView setSeparatorColor:[UIColor clearColor]];
            [self.listView reloadData];
        } else if ([[extroInfo valueForKey:API_Back_URLCode] isEqualToString:API_BitFollow_Code]){
            NSDictionary *info =  [extroInfo valueForKey:API_Back_ExtroInfo];
            BitSearchResultEntity *entity = [info valueForKey:@"btc"];
            if (entity){
                [entity setIs_follow:YES];
            }
           // self.followBlock(YES);
            [self showAlertToast:@"关注成功"];
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
        }

    } WithFailureBlock:^(id retrunParam, id extroInfo) {
        @strongify(self)
        if (!self)
        {
            return;
        }
        if ([[extroInfo valueForKey:API_Back_URLCode] isEqualToString:API_BitSerach_Code]){
            ApiError *error = (ApiError *)retrunParam;
            if (error.statusCode == 400){
                if (self.searchArray.count > 0){
                    [self.searchArray removeAllObjects];
                }
                [self.listView reloadData];
                
            }
        }
        [self.HUD hideAnimated:YES];
        if ([[extroInfo valueForKey:API_Back_URLCode] isEqualToString:API_BitFollow_Code]){
            [self showAlertToast:@"关注失败"];
        }
    }];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!_isSarch){
        if (self.hotArray.count < 4){
            return 1;
        } else {
            if (self.hotArray.count % 4 == 0){
                return self.hotArray.count /4;
            }else {
                return self.hotArray.count/4 + 1;
            }
        }
        
    }else {
        return self.searchArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!_isSarch){
        static NSString *hotIdentifier = @"HotCellIdentifier";
        BitSearchHotWordCell *cell = [tableView dequeueReusableCellWithIdentifier:hotIdentifier];
        if (!cell){
            cell = [[BitSearchHotWordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hotIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setDelegate:self];
        }
        
        NSInteger rowCount =  self.hotArray.count - (indexPath.row + 1) * 4;
        NSInteger lenthCount = self.hotArray.count - indexPath.row  * 4;
        
        if (rowCount >= 0){
            [cell setCellData:[self.hotArray subarrayWithRange:NSMakeRange(indexPath.row*4,4)]];
        } else {
            [cell setCellData:[self.hotArray subarrayWithRange:NSMakeRange(indexPath.row*4, lenthCount)]];
        }
        return cell;
        
    }else {
        static NSString *searchIdentifier = @"SearchCellIdentifier";
        BitSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:searchIdentifier];
        if (!cell){
            cell = [[BitSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchIdentifier];
            [cell setDelegate:self];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        BitSearchResultEntity *entity = [self.searchArray objectAtIndex:indexPath.row];
        [cell setCellData:entity withkey:self.searchField.text];
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isSarch){
        return 40;
    }
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!_isSarch){
        return 40;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!_isSarch){
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth - 15, 40)];
        [headerLabel setBackgroundColor:[UIColor whiteColor]];
        [headerLabel setTextColor:k_B5B5B5];
        [headerLabel setFont:SYS_FONT(16)];
        [headerLabel setText:@"大家都在搜"];
        [headerView addSubview:headerLabel];
        return headerView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isSarch){
        BitSearchResultEntity *entity = [self.searchArray objectAtIndex:indexPath.row];
        BDetailsController *detailsVc = [[BDetailsController alloc] init];
        [detailsVc setBitId:entity.btc_id];
        detailsVc.haveMyNavBar = YES;
        [detailsVc setNavititle:entity.btc_title_display];
        [self.navigationController pushViewController:detailsVc animated:YES];
    }
    
    
}


- (void)addFollowWithEntity:(BitSearchResultEntity *)entiy {
    [self.searchViewModel requestFollow:@{@"device_id":[NSString getDeviceIDInKeychain],@"btc_id":entiy.btc_id} withBackParam:@{@"btc":entiy} withNet:YES];
}


- (void)selectBitItem:(BitSearchHotEntity *)entity {
    BDetailsController *detailsVc = [[BDetailsController alloc] init];
    [detailsVc setBitId:entity.btc_id];
    detailsVc.haveMyNavBar = YES;
    [detailsVc setNavititle:entity.title];
    [self.navigationController pushViewController:detailsVc animated:YES];
}



//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    [self.listView setFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight - 65 - height)];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{
   [self.listView setFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight - 65)];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _isSarch = YES;
    [self.listView reloadData];
    
}

-(void)textFieldEditChanged:(UITextField *)textField{
    if (textField.text.length > 0){
        [self searchBitKeyWork:textField.text];
    }else {
        if (self.searchArray.count > 0){
            [self.searchArray removeAllObjects];
        }
        [self.listView reloadData];

    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField {
   [textField resignFirstResponder];
    return YES;
}


-(UITextField *)searchField {
    if (!_searchField){
        _searchField = [[UITextField alloc] initWithFrame:CGRectMake(28, 3, ScreenWidth - 110, 26)];
        [_searchField setClearButtonMode:UITextFieldViewModeAlways];
        [_searchField setReturnKeyType:UIReturnKeyDone];
        [_searchField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        [_searchField setDelegate:self];
        [_searchField setPlaceholder:@"输入你想要查找的币种"];
        
    }
    return _searchField;
}

- (BitSearchViewModel *)searchViewModel {
    if (!_searchViewModel){
        _searchViewModel = [[BitSearchViewModel alloc] init];
    }
    return _searchViewModel;
}

- (UITableView *)listView{
    if (!_listView){
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight - 65)];
        [_listView setDelegate:self];
        [_listView setDataSource:self];
    }
    return _listView;
}

- (NSMutableArray *)searchArray {
    if (!_searchArray){
        _searchArray = [[NSMutableArray alloc] init];
    }
    return _searchArray;
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
