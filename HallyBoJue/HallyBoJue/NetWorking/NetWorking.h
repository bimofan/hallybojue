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
#import "ModelHeaders.h"



typedef void (^RequestResultBlock)(BOOL isSuccess,id data);

@interface NetWorking : NSObject

+(NetWorking*)shareNetWorking;

-(void)RequestWithAction:(NSString*)action  Params:(NSDictionary*)param   itemModel:(id)model result:(RequestResultBlock)block;

-(void)RequestWithAction:(NSString*)action Params:(NSDictionary*)param  Data:(NSData*)data filename:(NSString*)fileName  result:(RequestResultBlock)block;


@end
