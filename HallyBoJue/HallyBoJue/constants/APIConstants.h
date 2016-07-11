//
//  APIConstants.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/2.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>


//本地
#define kRequestHeader  @"http://192.168.0.100/api/"





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
 *
 */

#define kWorkList       @"korder/workplacelist"










