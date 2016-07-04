//
//  APIConstants.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/2.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>


//本地
#define kRequestHeader  @"http://192.168.0.122/api/"





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



