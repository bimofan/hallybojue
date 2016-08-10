//
//  FollowModel.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/17.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "JSONModel.h"
#import "Usermodel.h"
#import "CUserModel.h"

@interface FollowModel : JSONModel


@property (nonatomic,assign) int follow_id;
@property (nonatomic,assign) int user_id;
@property (nonatomic,assign) int car_id;
@property (nonatomic,strong) NSString *next_time;
@property (nonatomic,strong) NSString *next_service;
@property (nonatomic,strong) NSString *store_name;
@property (nonatomic,strong) NSString *keeper_name;
@property (nonatomic,strong) NSString *order_time;


@property (nonatomic,strong) NSString *add_time;
@property (nonatomic,assign) int keeper_id;
@property (nonatomic,strong) NSDictionary *user;
@property (nonatomic,strong) CUserModel *cUserModel;

@property (nonatomic,strong) NSDictionary *car;
@property (nonatomic,strong) NSDictionary *service_order;

@property (nonatomic,assign) int iscall;
@property (nonatomic,strong) NSString *follow_time;





@end
