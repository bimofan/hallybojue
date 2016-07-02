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




@implementation HomeHeaderView



-(void)layoutSubviews
{
    CGFloat firstwith = 200;
    
    CGFloat with = (ScreenWidth - 6 - firstwith)/6;
    
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
    
    _levelLabel.text = [UserInfo getLevelString];
    
    
    
    
    
}


@end
