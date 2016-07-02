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

+(NSString*)getLevelString
{
    int level = [UserInfo getUserModel].level;
    
    NSString *levelStr = @"";
    
    switch (level) {
        case 1:
        {
            levelStr = @"一级管家";
            
        }
            break;
        case 2:
        {  levelStr = @"二级管家";
        }
            break;
        case 3:
        {
              levelStr = @"三级管家";
        }
            break;
        case 4:
        {
              levelStr = @"四级管家";
        }
            break;
        case 5:
        {
              levelStr = @"五级管家";
        }
            break;
            
            
        default:
            break;
    }
    
    return levelStr;
    
    
}
@end
