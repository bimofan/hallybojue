//
//  UserInfo.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/2.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Usermodel.h"

@interface UserInfo : NSObject


+(BOOL)saveUserInfo:(Usermodel*)user;
+(Usermodel*)getUserModel;
+(BOOL)hadLogin;



@end
