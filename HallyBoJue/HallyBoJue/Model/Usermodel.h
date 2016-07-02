//
//  Usermodel.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/2.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "JSONModel.h"

@interface Usermodel : JSONModel

@property (nonatomic) NSDictionary * avatar_img;
@property (nonatomic,strong) NSString *create_time;
@property(nonatomic,strong) NSString *desc;
@property (nonatomic,assign) int id;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *real_name;
@property(nonatomic,assign) int store_id;
@property (nonatomic,assign) int level;




@end