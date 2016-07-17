//
//  APIConstants.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/2.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>


//本地
#define kRequestHeader  @"http://192.168.0.107/api/"

//#define kRequestHeader  @"http://114.55.42.248/public/api/user/login"



#pragma mark - 接口

//登录
#define kLoginAction     @"kuser/login"

//实时订单
#define kNewOrder         @"korder/neworder"

//抢单
/*
 * order_id
 * keeper_id
 */
#define kCatchOrder        @"korder/catchorder"

//我的预约列表
/*
 * keeper_id
 * page
 * pagesize
 */
#define kMyOrderList       @"korder/myorderlist"

//我的客户列表
/*
 *@pragma
 * keeper_id 
 * pagesize
 * page
 */
#define kMyCustomerList     @"kcustomer/customerlist"

//新增客户并给客户新增汽车
/*
 *  keeper_id
 *  mobile
 *  user_real_name
 * 默认密码 123456
 *  plate_number
 *  brand_id
 */
#define kAddCustomer        @"kcustomer/addcustomer"

/** 搜索汽车品牌或者系列
 *
 *  brand_name
 *
 **/
#define kSearchcarbrand     @"kcustomer/searchcarbrand"



/*
 *   搜索客户
 *
 *   keyword
 */
#define kSearchCustomer     @"kcustomer/searchcustomer"



/*  环车检查表
 *
 */
#define kChecklist       @"korder/checklist"

/*  工位列表
 *  store_id
 */

#define kWorkPlaceList       @"korder/workplacelist"



/*  技师列表
 *
 *  store_id
 *
 */
#define kWorkerList       @"korder/workerlist"


/*  开始服务
 *  order_id
 *  expecte_time
 *  services
 */
#define kOrderStartService  @"korder/startservice"


/**  提交环车检查
 *  service_order_id
 *   user_id
 *  keeper_id
 *  store_id
 *  position
 *  position_problem
 *  advise
 *  suggest
 *  user_car_id
 */
#define kSummitcarcheck    @"korder/summitcarcheck"


/**  修改预约状态
 *
 *  order_id
 *   status   1预约中  2预约确认  3派工中 4服务中 5待支付 6待评价 7订单完成 8支付异常
 */
#define kCheckappoint     @"korder/checkappoint"

/** 服务列表
 *
 *
 */
#define kServiceList    @"kservice/servicelist"


/*  添加服务
 *  jsonString=
    "service_id
 *  add_time
 *  order_id"
 */
#define kAddService     @"kservice/addservice"

/*  获取用户会员卡
 *  user_id
 *  car_id
 *
 */
#define kGetUserVipCard   @"kuser/getvipcard"


/*  结算
 *  order_id
 *  services (jsonstring,array)
 */
#define kSummitOrder    @"korder/summitorder"

/*  获取用户汽车
 *  user_id
 *
 */
#define kGetUserCars     @"kcustomer/getusercars"




/* 代客下单
 *  user_id
 *  store_id
 *  keeper_id
 *  car_id
 *  services (jsonstring,array)
 */
#define kAddUserAppoint   @"kcustomer/adduserappoint"








