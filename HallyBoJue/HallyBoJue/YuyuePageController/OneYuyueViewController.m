//
//  OneYuyueViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/8.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "OneYuyueViewController.h"
#import "OneYuyueCell.h"
#import "AddServiceViewController.h"
#import "ToPrintViewController.h"




@interface OneYuyueViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIPrintInteractionControllerDelegate>

@property (nonatomic,strong) UIPrintInteractionController *printer;
@property (nonatomic,strong) ToPrintViewController *toPrintViewController;


@end

@implementation OneYuyueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _statusLabel.clipsToBounds = YES;
    _statusLabel.layer.cornerRadius = kCornerRadous;
    
    _timeTwoLabel.clipsToBounds = YES;
    _timeTwoLabel.layer.cornerRadius = kCornerRadous;
    
    _checkButton.clipsToBounds = YES;
    _checkButton.layer.cornerRadius = kCornerRadous;
    
    _checkButton.layer.borderColor = kBorderColor.CGColor;
    _checkButton.layer.borderWidth = 1;
    
    
    _sendButton.clipsToBounds = YES;
    _sendButton.layer.cornerRadius = kCornerRadous;
    _sendButton.layer.borderWidth = 1;
    _sendButton.layer.borderColor =kBorderColor.CGColor;
    
    
    _addServiceButton.clipsToBounds = YES;
    _addServiceButton.layer.cornerRadius = kCornerRadous;
    _addServiceButton.layer.borderWidth = 1;
    _addServiceButton.layer.borderColor = kBorderColor.CGColor;
    
    _printSheetButotn.clipsToBounds= YES;
    _printSheetButotn.layer.cornerRadius = kCornerRadous;
    _printSheetButotn.layer.borderWidth = 1;
    _printSheetButotn.layer.borderColor = kBorderColor.CGColor;
    
    _showvipcardbutton.clipsToBounds= YES;
    _showvipcardbutton.layer.cornerRadius = kCornerRadous;
    _showvipcardbutton.layer.borderWidth = 1;
    _showvipcardbutton.layer.borderColor = kBorderColor.CGColor;
    
    
    
    
    
    _headImageView.clipsToBounds=  YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    
    
    
    _serviceTable.delegate = self;
    _serviceTable.dataSource = self;
    
    
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(addserviceNotice:) name:kAddServieNotice object:nil];
    
    
    

}


-(ToPrintViewController*)toPrintViewController
{
    if (!_toPrintViewController) {
        
        _toPrintViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ToPrintViewController"];
        _toPrintViewController.view.frame = CGRectMake(0, 0, kPrintpageWidth, kPrintpageHeight);
        
    }
    
    return _toPrintViewController;
    
}

-(UIPrintInteractionController*)printer
{
    if (!_printer) {
        
        _printer = [UIPrintInteractionController sharedPrintController];
        
        _printer.delegate = self;
        
    }
    
    return _printer;
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAddService object:nil];
    
}

-(void)setOrdermodel:(OrderModel *)ordermodel
{
    _ordermodel = ordermodel;
    
     _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    if (_ordermodel.usermodel.avatar) {
        
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_ordermodel.usermodel.avatar objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
    }
    else
    {
        _headImageView.image = kDefaultHeadImage;
        
    }
    
    
    _realnameLabel.text = ordermodel.usermodel.nickname;
    
    _plateLabel.text = ordermodel.car_plate_num;
    
    _mobileLabel.text = ordermodel.usermodel.mobile;
    
    _timeOneLabel.text = ordermodel.order_time;
    
    _statusLabel.text = ordermodel.status_str;
    
    _timeTwoLabel.text = ordermodel.order_time;
    
    _vipcard_Label.text = [NSString stringWithFormat:@" %@ %@",ordermodel.usermodel.vipcard_name,ordermodel.usermodel.vip_address];
    
    
    if (_ordermodel.status == 1)//预约中
    {
        
        _checkButton.hidden = YES;
        _addServiceButton.hidden = YES;
        
        [_sendButton setTitle:@"确认预约" forState:UIControlStateNormal];
        
        
    }
    else  //预约确认
    {
        _checkButton.hidden = NO;
        _addServiceButton.hidden = NO;
        
        [_sendButton setTitle:@"开始服务" forState:UIControlStateNormal];
    }
    
    
    [_serviceTable reloadData];
    
    
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _ordermodel.services.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 5)];
    
    backView.backgroundColor = kBackgroundColor;
    
    
    return backView;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    OneYuyueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneYuyueCell"];
    
    cell.service_nameLabel.text = [[_ordermodel.services objectAtIndex:indexPath.section] objectForKey:@"name"];
    
    
    
    return cell;
    
    
}



- (IBAction)checkAction:(id)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(didSelectedCarCheck:)]) {
        
        [self.delegate didSelectedCarCheck:_ordermodel];
        
    }
 
    
    
}
- (IBAction)sendAction:(id)sender {
    
   
 
    if (_ordermodel.status == 1)//预约中
    {
        if ([self.delegate respondsToSelector:@selector(startSendWorders:)]) {
            
            
            [self.delegate startSendWorders:_ordermodel];
            
            
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"服务预估时间" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle  = UIAlertViewStylePlainTextInput;
        
        alert.tag = 9999;
        
        [alert show];
    }

    
    
    
    
    
    
}
- (IBAction)addServiceAction:(id)sender {
    
   
    
    
    NSMutableDictionary *mudict = [[NSMutableDictionary alloc]init];
    [mudict setObject:@(_ordermodel.store_id) forKey:@"store_id"];
    [mudict setObject:@(_ordermodel.user_id) forKey:@"user_id"];
    [mudict setObject:@(_ordermodel.id) forKey:@"service_order_id"];
    [mudict setObject:@(_ordermodel.car_id) forKey:@"user_car_id"];
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:kAddNewServiceType];

    
    [[NSUserDefaults standardUserDefaults] setObject:mudict forKey:kOrderInfo];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AddServiceNav"];
    
    
    [self.superViewController presentViewController:nav animated:YES completion:nil];
    
    
    
    
}


#pragma mark - 接收添加服务通知
-(void)addserviceNotice:(NSNotification*)note
{
    NSLog(@"object:%@",note.object);
    
    NSMutableArray *muarray = [[NSMutableArray alloc]init];
    
    [muarray addObjectsFromArray:_ordermodel.services];
    
    
    
    NSArray *newservices = note.object;
    
    for (int i = 0; i < newservices.count; i++) {
        
        NSDictionary *dict  = [newservices objectAtIndex:i];
        
        BOOL contented = NO;
        
        int service_id = [[dict objectForKey:@"id"]intValue];
        
        for (int d = 0; d < _ordermodel.services.count; d++) {
            
            NSDictionary *temdict = [_ordermodel.services objectAtIndex:d];
            
            int temid = [[temdict objectForKey:@"id"]intValue];
            
            if (temid == service_id) {
                
                contented = YES;
            }
        }
        
        if (!contented) {
            
            [muarray addObject:dict];
            
        }
    }
    
    
    
    
    
    _ordermodel.services = muarray;
    
    
    [_serviceTable reloadData];
    
    
}


#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 9999  && buttonIndex == 1) {
        
        UITextField *firstTF = [alertView textFieldAtIndex:0];
        
        int minis = [firstTF.text intValue];
        
        if ([self.delegate respondsToSelector:@selector(startSendWorders:)]) {
            
            _ordermodel.service_time = minis;
            _ordermodel.expecte_time = [NSString stringWithFormat:@"%d",minis*60];
            
            
            [self.delegate startSendWorders:_ordermodel];
            
            
        }
        
    }
}
- (IBAction)printAction:(id)sender {
    

    
 
        int order_id = _ordermodel.id;
    
    
    [[NetWorking shareNetWorking] RequestWithAction:kGetCarCheckList Params:@{@"service_order_id":@(order_id)} itemModel:nil result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
            DataModel *model = (DataModel*)data;
            
            self.toPrintViewController.orderModel = _ordermodel;
            
            self.toPrintViewController.carcheckArray =model.items;
            
            
//            
            UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
                        pic.delegate = self;
            
            UIPrintInfo *printInfo = [UIPrintInfo printInfo];
            printInfo.outputType = UIPrintInfoOutputGeneral;
            printInfo.jobName = @"工单";
            pic.printInfo = printInfo;
            
            //    UISimpleTextPrintFormatter *textFormatter = [[UISimpleTextPrintFormatter alloc]
            //                                                 initWithText:@"teatagsatagabagsfdagatg"];
            //    textFormatter.startPage = 0;
            //    textFormatter.contentInsets = UIEdgeInsetsMake(72.0, 72.0, 72.0, 72.0); // 1 inch margins
            //    textFormatter.maximumContentWidth = 6 * 72.0;
            //    pic.printFormatter = textFormatter;
            //
            pic.showsPageRange = NO;
            
            UIPrintFormatter *fommater = [[UIPrintFormatter alloc]init];
            fommater.contentInsets =UIEdgeInsetsMake(72.0, 72.0, 72.0, 72.0);
            fommater.maximumContentWidth = 6 * 72.0;
//            pic.printFormatter = fommater;
            
            
            pic.printingItem = [CommonMethods convertViewToImage:self.toPrintViewController.view];
            
            
            
            void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
            ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
                if (!completed && error) {
                    NSLog(@"Printing could not complete because of error: %@", error);
                }
            };
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [pic presentFromBarButtonItem:sender animated:YES completionHandler:completionHandler];
                
            } else {
                
                [pic presentAnimated:YES completionHandler:completionHandler];
            }
            
        }
    }];
    
    
    
}

#pragma mark  UIPrintInteractionControllerDelegate
-(void)printInteractionControllerWillStartJob:(UIPrintInteractionController *)printInteractionController
{
    
}

-(void)printInteractionControllerDidFinishJob:(UIPrintInteractionController *)printInteractionController
{
    [CommonMethods showDefaultErrorString:@"打印成功"];
    
}

- (IBAction)showvipAction:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:@(_ordermodel.user_id) forKey:kGetVipCardUser_id];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"showvipnav"];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
    
}
@end
