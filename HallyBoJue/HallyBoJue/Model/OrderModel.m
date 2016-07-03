//
//  OrderModel.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/3.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    NSLog(@"ordermodel undifined key:%@",key);
    
}

-(void)setNilValueForKey:(NSString *)key
{
    
    
    if ([key isEqualToString:@"end_time"]) {
        
        _end_time = @"";
        
    }
    
}

@end
