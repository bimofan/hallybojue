//
//  DataModel.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/3.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"datamodel undefined key:%@",key);
    
}
@end
