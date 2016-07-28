//
//  GetIPAddress.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/27.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetIPAddress : NSObject
+ (NSString *) whatismyipdotcom;
+ (NSString *)getIPAddress:(BOOL)preferIPv4;
+ (NSString *)newIpAddress;

@end
