//
//  AddServiceViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/13.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"

@protocol AddNewServiceDelegate <NSObject>

-(void)didSelectedNewService:(NSArray*)array;


@end


@interface AddServiceViewController : BaseViewController


@property (nonatomic,assign) id <AddNewServiceDelegate> delegate;


@property (nonatomic,assign) NSInteger showType;  // 1预约中添加服务  2待客下单添加服务

@property (nonatomic,strong) OrderModel *orderModel;

@property (weak, nonatomic) IBOutlet UITableView *firstTableView;


@property (weak, nonatomic) IBOutlet UITableView *secondTableView;

@property (weak, nonatomic) IBOutlet UITableView *thirdTableView;

@end
