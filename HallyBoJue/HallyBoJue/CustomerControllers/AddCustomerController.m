//
//  AddCustomerController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/5.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "AddCustomerController.h"

@interface AddCustomerController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate>

@property (nonatomic,strong) NSMutableArray *searchResults;
@property (nonatomic,strong) NSString *brand_id;

@end

@implementation AddCustomerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    _nameBackView.clipsToBounds = YES;
    _nameBackView.layer.cornerRadius = kCornerRadous;
    
    _mobileBackView.clipsToBounds = YES;
    _mobileBackView.layer.cornerRadius = kCornerRadous;
    
    _nextButton.clipsToBounds = YES;
    _nextButton.layer.cornerRadius = kCornerRadous;
    _nextButton.layer.borderWidth = 1;
    _nextButton.layer.borderColor = kBorderColor.CGColor;
    
    _countDownLabel.hidden = YES;
    

    
    _carSearchBar.delegate = self;
    
    _carTableView.delegate = self;
    _carTableView.dataSource = self;
    
    _codeTF.delegate = self;
    _mobileTF.delegate = self;
    _carnunTF.delegate = self;

    
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    _codeTF.text = nil;
    _userrealnameTF.text = nil;
    _mobileTF.text = nil;
    _carnunTF.text = nil;
    
    [_searchResults removeAllObjects];
    
    [_countDownButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    _countDownButton.hidden = NO;
    _countDownLabel.hidden  =YES;
    
}

#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    
    [self searchcar];
    
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [UIView animateWithDuration:0.3 animations:^{
       
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 300);
        
        
    }];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 300);
        
        
    }];
}

#pragma mark - UITableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"carcell"];
    
    NSDictionary *dict = [_searchResults objectAtIndex:indexPath.section];
    
    NSString *name = [NSString stringWithFormat:@"%@ %@ %@ %@",[dict objectForKey:@"series"],[dict objectForKey:@"model_year"],[dict objectForKey:@"model_name"],[dict objectForKey:@"gearbox"]];
    
    cell.textLabel.text = name;
    
    cell.textLabel.textColor = kDarkGrayColor;
    
    
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _searchResults.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView*blankView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    
    blankView.backgroundColor = kBackgroundColor;
    
    
    return blankView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dict = [_searchResults objectAtIndex:indexPath.section];
    
    NSString *name = [NSString stringWithFormat:@"%@ %@ %@ %@",[dict objectForKey:@"series"],[dict objectForKey:@"model_year"],[dict objectForKey:@"model_name"],[dict objectForKey:@"gearbox"]];
    
    _carbrandLabel.text = name;
    
    _brand_id = [dict objectForKey:@"id"];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


#pragma mark  -搜索品牌
-(void)searchcar
{
    [[NetWorking shareNetWorking] RequestWithAction:kSearchcarbrand Params:@{@"brand_name":_carSearchBar.text} itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess)
        {
            
            DataModel *model = (DataModel*)data;
            
            _searchResults = [[NSMutableArray alloc]init];
            
            [_searchResults addObjectsFromArray:model.items];
            
            
            [_carTableView reloadData];
            
        }
        
    }];
}


-(void)summitData
{
    
    int keeper_id = [UserInfo getkeeperid];
    
    [[NetWorking shareNetWorking] RequestWithAction:kAddCustomer Params:@{@"mobile":_mobileTF.text,@"nickname":_userrealnameTF.text,@"keeper_id":@(keeper_id),@"plate_number":_carnunTF.text,@"brand_id":_brand_id,@"code":_codeTF.text} itemModel:nil result:^(BOOL isSuccess, id data) {
       
        
        if (isSuccess) {
            
            [CommonMethods showDefaultErrorString:@"添加成功!"];
            
            if ([self.addCustomerDelegate respondsToSelector:@selector(didAddCustomer)]) {
                
                [self.addCustomerDelegate didAddCustomer];
                
            }
        }
        
    }];
}








- (IBAction)nextAction:(id)sender {
    
    if (![CommonMethods checkTel:_mobileTF.text]) {
        
        [CommonMethods showDefaultErrorString:@"请填写正确的手机号码"];
        
        
        return;
    }
    
    if (_userrealnameTF.text.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"请填写客户姓名"];
        
        return;
    }
    
    if (_carnunTF.text.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"请填写车牌"];
        
        return;
    }
    
    if (_brand_id.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"请选择品牌车型"];
        
        return;
    }
    
    
    [self summitData];
    
    
    
}
- (IBAction)countDownAction:(id)sender {
    
    
    if (![CommonMethods checkTel:_mobileTF.text]) {
        
        return [CommonMethods showDefaultErrorString:@"请填写正确的手机号码"];
    }
    
    [[NetWorking shareNetWorking] RequestWithAction:kSendSMSCode Params:@{@"mobile":_mobileTF.text} itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
        
              [self getAutoCodeTime];
            
            
        }
        
        
        
    }];
    
    
  
    
    
    
}


#pragma mark - 倒计时
-(void)getAutoCodeTime{
    __block int timeout=180;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_countDownButton setTitle:@"发送验证码" forState:UIControlStateNormal] ;
                _countDownButton.enabled = YES;
                _countDownButton.hidden = NO;
                
                _countDownLabel.text = nil;
                _countDownLabel.hidden = YES;
                
                
            });
        }else{
            int seconds = timeout % 181;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //                NSLog(@"____%@",strTime);
                
                _countDownButton.hidden = YES;
                
                _countDownLabel.hidden = NO;
                
                _countDownLabel.text = [NSString stringWithFormat:@"%@s",strTime];
                
                //                [_sendCodeButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal] ;
                
                
                
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{


        
        [UIView animateWithDuration:0.3 animations:^{
           
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y -190);
            
        }];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField != _userrealnameTF) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 190);
            
        }];
    }
}


@end
