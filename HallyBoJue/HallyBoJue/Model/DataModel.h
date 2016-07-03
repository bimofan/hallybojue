//
//  DataModel.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/3.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "JSONModel.h"

@interface DataModel : JSONModel

@property (nonatomic,assign) int total;
@property (nonatomic,assign) int totalpage;
@property (nonatomic,assign) int pagesize;
@property (nonatomic,assign) int currentpage;
@property (nonatomic,assign) int nextpage;
@property (nonatomic,strong) NSArray *items;
@property (nonatomic,strong) NSMutableArray *itemsModelsArray;


@end
