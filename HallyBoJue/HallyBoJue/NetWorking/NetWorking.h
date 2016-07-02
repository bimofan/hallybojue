//
//  NetWorking.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/2.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIConstants.h"
#import "AFNetworking.h"


typedef void (^RequestResultBlock)(BOOL isSuccess,id data);

@interface NetWorking : NSObject

+(NetWorking*)shareNetWorking;

-(void)RequestWithAction:(NSString*)action  Params:(NSDictionary*)param result:(RequestResultBlock)block;


@end
