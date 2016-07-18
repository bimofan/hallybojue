//
//  CUserModel.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/3.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "JSONModel.h"

@interface CUserModel : JSONModel



@property (nonatomic,strong) NSString *user_id;
@property (nonatomic,strong) NSArray *email;
@property (nonatomic,strong) NSString *user_real_name;
@property (nonatomic,assign) int sex;
//@property (nonatomic,assign) float user_money;
//@property (nonatomic,assign) float frozen_money;
//@property (nonatomic,assign) float pay_points;
@property (nonatomic,assign) int address_id;
@property (nonatomic) NSString *  mobile;
//@property (nonatomic,assign) BOOL mobile_validated;
@property (nonatomic,strong) NSDictionary *avatar;

@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,strong) NSString *level_str;
@property (nonatomic,assign) int level;
@property (nonatomic,assign) float discount;
@property (nonatomic,assign) float total_amount;
@property (nonatomic,assign) int is_lock;
@property (nonatomic,strong) NSString *level_name;
@property (nonatomic,strong) NSString *brand_name;
@property (nonatomic,strong) NSString *last_service_time;
@property (nonatomic,strong) NSArray *cars;
@property (nonatomic,strong) NSArray *service_orders;
@property (nonatomic,strong) NSString *add_time;
@property (nonatomic,strong) NSString *vip_address;








@end
