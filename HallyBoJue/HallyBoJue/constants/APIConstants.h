//
//  APIConstants.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/2.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>



//本地
//#define kRequestHeader  @"http://192.168.0.120/api/"


//old
//#define kRequestHeader  @"http://120.55.86.7/api/"


//new
#define kRequestHeader  @"http://120.76.207.52/api/"



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
 *  code
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

/*  车位列表
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


/*  跟进列表
 *
 *  keeper_id
 *   pagesize
 *   page
 */
#define kGetFollowlist    @"kfollow/followlist"


/**  FAQ
 *
 *
 *
 */
#define  kKeeperfaq       @"kservice/keeperfaq"


/**  添加跟进提醒
 *   user_id
 *   car_id
 *   next_time
 *   next_service
 *   keeper_id
 */
#define kAddFollow      @"kfollow/addfollow"


/*  获取会员卡列表
 *
 *
 */
#define kGetVipCardTemplates @"kcustomer/getvipcardtemplate"


/*  添加会籍卡
 *  user_id
 *  vipcard_template_id
 *   amount
 *  keeper_id
 *  car_id
 */
#define kAddVipCard     @"kcustomer/addvipcard"


/*  修改头像
 *  keeper_id
 *  avatar
 *
 */
#define  kChangeAvatar   @"kuser/changeavatar"


/*  修改密码
 *  oldpass
 *   newpass
 *   keeper_id
 */
#define kChangePassWord  @"kuser/changepassword"


/** 推荐服务
 *  keeper_id
 *   user_id
 *  user_car_id
 *  service_id
 *  service_name
 *  notes
 *
 *
 */
#define kPushService     @"kcustomer/pushservice"


/*  自己的排行信息
 *  keeper_id
 *  store_id
 */
#define kMyRank    @"kuser/moneycount"


/*  排行榜
 *
 *
 *
 */
#define kRankList   @"kuser/ranklist"

/* 获取短息验证码
 *  mobile
 *
 */
#define kSendSMSCode   @"kcustomer/sendsmscode"



/*  保存车辆信息
 *  
 *  id
 *  mileage
 *  vi_number
 *  engine_number
 */
#define kChangedcarinfo   @"kcustomer/changedcarinfo"


/*  推送列表
 *  page
 *  pagesize
 *  user_id
 *  keeper_id
 */
#define kPushHistorey      @"kcustomer/pushhistory"







