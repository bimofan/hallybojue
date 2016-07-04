//
//  UserInfo.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/2.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "UserInfo.h"
#import "NSUserDefaultKeys.h"

@implementation UserInfo



+(int)getkeeperid
{
    
    Usermodel *model = [self getUserModel];
    
    
    return model.keeper_id;
    
}

+(BOOL)saveUserInfo:(Usermodel *)user
{
    
    NSDictionary *dict = [user toDictionary];
    
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:kUserInfo];
    
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kHadLogin];
    
    
    
    
    return [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    
    
}

+(Usermodel*)getUserModel
{
    Usermodel *model = [[Usermodel alloc]init];
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
    
    
    [model setValuesForKeysWithDictionary:dict];
    
    
    return model;
    
    
}

+(BOOL)hadLogin
{
    
    return [[NSUserDefaults standardUserDefaults]boolForKey:kHadLogin];
    
    
}


@end
