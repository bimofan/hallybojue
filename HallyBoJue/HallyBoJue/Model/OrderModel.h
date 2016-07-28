//
//  OrderModel.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/3.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "JSONModel.h"
#import "DataModel.h"
#import "CUsermodel.h"

@interface OrderModel : JSONModel


@property (nonatomic) int id;
@property (nonatomic,strong) NSString *so_number;
@property (nonatomic,assign) int user_id;
@property (nonatomic,assign) int store_id;
@property (nonatomic,assign) int keeper_id;
@property (nonatomic,assign) int order_service_id;
@property (nonatomic,strong) NSArray *services;
@property (nonatomic,strong) NSString *service_name;
@property (nonatomic,strong) NSString *order_time;
@property (nonatomic,strong) NSString *add_time;
@property (nonatomic,assign) int status;
@property (nonatomic,assign)    int workplace_id;
@property (nonatomic,strong) NSString *workplay_name;
@property (nonatomic,assign) int workers_id;
@property (nonatomic,strong) NSString *start_time;
@property (nonatomic,strong) NSString *end_time;
@property (nonatomic,strong) NSString *expecte_time;
@property (nonatomic,assign) int order_type;
@property (nonatomic,strong) NSDictionary *user;
@property (nonatomic,strong) CUserModel *usermodel;

@property (nonatomic,strong) NSString *status_str;
@property (nonatomic,strong) NSString *order_address;
@property (nonatomic,strong) NSDictionary *address_location;

@property (nonatomic,strong) NSString *car_plate_num;

@property (nonatomic,assign) int  car_id;

@property (nonatomic,assign ) float order_amount;
@property (nonatomic,assign ) float  order_old_amount;

@property (nonatomic,assign) NSInteger pay_type;














@end
