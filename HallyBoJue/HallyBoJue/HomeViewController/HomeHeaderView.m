//
//  HomeHeaderView.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/3.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "HomeHeaderView.h"
#import "Constants.h"
#import "UserInfo.h"
#import "Usermodel.h"
#import "UIButton+WebCache.h"

#import "UIImageView+WebCache.h"

static CGFloat lineWith = 2;



@implementation HomeHeaderView



-(void)layoutSubviews
{
    CGFloat firstwith = 180;
    
    CGFloat with = (ScreenWidth - 6*lineWith - firstwith)/6;
    
    _oneWith.constant = firstwith;
    _twoWith.constant = with;
    _threeWith.constant = with;
    _fourWith.constant = with;
    _fiveWith.constant = with;
    _sixWith.constant = with;
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.height/2;
    
}

-(void)setdata
{
    
    Usermodel *model = [UserInfo getUserModel];
    
    if ([model.avatar_img isKindOfClass:[NSDictionary class]]) {
        
          [_headImageView sd_setImageWithURL:[NSURL URLWithString:[model.avatar_img objectForKey:@"origin"] ] placeholderImage:kDefaultHeadImage];
        
    }
  
    
    _realnameLabel.text = model.real_name;
    
    _levelLabel.text = model.level_name ? model.level_name:@"";

    
    
    
    
    
}

-(void)setRankData:(NSDictionary *)rankData
{
    _todayNumLabel.text = [NSString stringWithFormat:@"%@",[rankData objectForKey:@"newuser_today"]];
    _monthNumLabel.text = [NSString stringWithFormat:@"%@",[rankData objectForKey:@"newuser_month"]];
    _todayTotalLabel.text = [NSString stringWithFormat:@"%@",[rankData objectForKey:@"today_money"]];
    _monthTotalLabel.text = [NSString stringWithFormat:@"%@", [rankData objectForKey:@"month_money"]];
    _shopRankLabel.text =  [NSString stringWithFormat:@"%@",[rankData objectForKey:@"store_rank"]];
    _areaRankLabel.text =  [NSString stringWithFormat:@"%@",[rankData objectForKey:@"area_rank"]];
 }


@end
