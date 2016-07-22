//
//  HomeHeaderView.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/3.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHeaderView : UIView





@property (weak, nonatomic) IBOutlet NSLayoutConstraint *oneWith;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *twoWith;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *threeWith;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fourWith;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fiveWith;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sixWith;


@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *realnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopRankLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaRankLabel;

-(void)setdata;
-(void)setRankData:(NSDictionary*)rankData;


@end
