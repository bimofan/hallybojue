//
//  InServiceViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/29.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "InServiceViewController.h"
#import "FiveYuYueCell.h"
#import "ToPrintViewController.h"


@interface InServiceViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIPrintInteractionControllerDelegate>
@property (nonatomic,strong) ToPrintViewController *toPrintViewController;

@end

@implementation InServiceViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _addServiceButton.clipsToBounds = YES;
    _addServiceButton.layer.cornerRadius = kCornerRadous;
    _addServiceButton.layer.borderColor = kBorderColor.CGColor;
    _addServiceButton.layer.borderWidth = 1;
    
    _doneService.clipsToBounds = YES;
    _doneService.layer.cornerRadius = kCornerRadous;
    _doneService.layer.borderWidth = 1;
    _doneService.layer.borderColor = kBorderColor.CGColor;
    
    _headImageVie.clipsToBounds = YES;
    _headImageVie.layer.cornerRadius = _headImageVie.frame.size.width/2;
    _headImageVie.contentMode = UIViewContentModeScaleAspectFill;
    
    
    
    _printButton.clipsToBounds= YES;
    _printButton.layer.cornerRadius = kCornerRadous;
    _printButton.layer.borderColor = kBorderColor.CGColor;
    _printButton.layer.borderWidth = 1;
    
    _vipcardButton.clipsToBounds =YES;
    _vipcardButton.layer.cornerRadius = kCornerRadous;
    _vipcardButton.layer.borderColor = kBorderColor.CGColor;
    _vipcardButton.layer.borderWidth = 1;
    
    
    
    _serviceTable.delegate = self;
    _serviceTable.dataSource = self;
    
     [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(addserviceNotice:) name:kAddServieNotice object:nil];
    
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel = orderModel;
    
    [_headImageVie sd_setImageWithURL:[NSURL URLWithString:[[_orderModel.user objectForKey:@"avatar"] objectForKey:@"origin"]] placeholderImage:kDefaultHeadImage];
    
    
    _namLabel.text = _orderModel.usermodel.nickname;
    
    _timeLabel.text = _orderModel.order_time;
    
    _plate_number_Label.text = _orderModel.car_plate_num;
    
    _mobileLabel.text = _orderModel.usermodel.mobile;
    
    NSString *vipcard_name = orderModel.usermodel.vipcard_name;
    NSString *vip_address = orderModel.usermodel.vip_address;
    
    if (!vipcard_name) {
        
        vipcard_name = @"";
    }
    
    if (!vip_address) {
        vip_address = @"";
    }
     _vipcard_Label.text = [NSString stringWithFormat:@" %@ %@",vipcard_name,vip_address];
    
    _status_Label.text = _orderModel.status_str;
    
    
    
    [_serviceTable reloadData];
    
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  _orderModel.services.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FiveYuYueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FiveYuYueCell"];
    
    if (_orderModel.services.count > indexPath.section) {
        
        NSDictionary *service = [_orderModel .services objectAtIndex:indexPath.section];
        
        cell.serviceNameLabel.text = [service objectForKey:@"name"];
        
    }
    
    
    return cell;
    
    
}

-(ToPrintViewController*)toPrintViewController
{
    if (!_toPrintViewController) {
        
        _toPrintViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ToPrintViewController"];
        _toPrintViewController.view.frame = CGRectMake(0, 0, kPrintpageWidth, kPrintpageHeight);
        
    }
    
    return _toPrintViewController;
    
}




- (IBAction)showvipcardAction:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:@(_orderModel.user_id) forKey:kGetVipCardUser_id];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"showvipnav"];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
    
}

#pragma mark - 打印

- (IBAction)printAction:(id)sender {
    
    
    int order_id = _orderModel.id;
    
    
    [[NetWorking shareNetWorking] RequestWithAction:kGetCarCheckList Params:@{@"service_order_id":@(order_id)} itemModel:nil result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
            DataModel *model = (DataModel*)data;
            
            self.toPrintViewController.orderModel = _orderModel;
            
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



#pragma mark - 添加服务


- (IBAction)addServiceAction:(id)sender {
    
    
    NSMutableDictionary *mudict = [[NSMutableDictionary alloc]init];
    [mudict setObject:@(_orderModel.store_id) forKey:@"store_id"];
    [mudict setObject:@(_orderModel.user_id) forKey:@"user_id"];
    [mudict setObject:@(_orderModel.id) forKey:@"service_order_id"];
    [mudict setObject:@(_orderModel.car_id) forKey:@"user_car_id"];
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:kAddNewServiceType];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:mudict forKey:kOrderInfo];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AddServiceNav"];
    
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
    
    
    
}

#pragma mark - 接收添加服务通知
-(void)addserviceNotice:(NSNotification*)note
{
    NSLog(@"object:%@",note.object);
    
    NSMutableArray *muarray = [[NSMutableArray alloc]init];
    
    [muarray addObjectsFromArray:_orderModel.services];
    
    
    
    NSArray *newservices = note.object;
    
    for (int i = 0; i < newservices.count; i++) {
        
        NSDictionary *dict  = [newservices objectAtIndex:i];
        
        BOOL contented = NO;
        
        int service_id = [[dict objectForKey:@"id"]intValue];
        
        for (int d = 0; d < _orderModel.services.count; d++) {
            
            NSDictionary *temdict = [_orderModel.services objectAtIndex:d];
            
            int temid = [[temdict objectForKey:@"id"]intValue];
            
            if (temid == service_id) {
                
                contented = YES;
            }
        }
        
        if (!contented) {
            
            [muarray addObject:dict];
            
        }
    }
    
    
    
    
    
    _orderModel.services = muarray;
    
    
    [_serviceTable reloadData];
    
    
}


- (IBAction)doneServiceAction:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定完成吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    alert.tag = 9999;
    
    [alert show];

    
    
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 9999 && buttonIndex == 1) {
        
        
        
        [[NetWorking shareNetWorking] RequestWithAction:kCheckappoint Params:@{@"order_id":@(_orderModel.id),@"status":@(5)} itemModel:nil result:^(BOOL isSuccess, id data) {
            
            if (isSuccess) {
                
                
                _orderModel.status = 5;
                _orderModel.status_str = @"服务完成";
                
                if ([self.delegate respondsToSelector:@selector(newDoneService:)]) {
                    
                    [self.delegate newDoneService:_orderModel];
                    
                }
                
         
                
            }
            
            
            
        }];
    }
}

#pragma mark  UIPrintInteractionControllerDelegate
-(void)printInteractionControllerWillStartJob:(UIPrintInteractionController *)printInteractionController
{
     [CommonMethods showDefaultErrorString:@"开始打印"];
}

-(void)printInteractionControllerDidFinishJob:(UIPrintInteractionController *)printInteractionController
{

    
}


@end
