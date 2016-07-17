//
//  SelectTimeView.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/17.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "SelectTimeView.h"
#import "Constants.h"
@implementation SelectTimeView





-(void)layoutSubviews
{
    
    self.backgroundColor = [UIColor clearColor];
    
    _conroll = [[UIControl alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, ScreenHeight)];
    
    [_conroll addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    
    _conroll.backgroundColor = kLighGrayBackColor;;
    
    [self addSubview:_conroll];
    
    
    [self bringSubviewToFront:_backVie];
    
    
    _backVie.backgroundColor = [UIColor whiteColor];
    _backVie.clipsToBounds =YES;
    _backVie.layer.cornerRadius = kCornerRadous;
    
    _okButton.clipsToBounds=  YES;
    _okButton.layer.cornerRadius = kCornerRadous;
    
    _datePicker.minimumDate = [NSDate date];
    
    
}

-(void)setSelectedDate:(NSDate *)selectedDate
{
    _selectedDate = selectedDate;
    
    _datePicker.date = _selectedDate;
    
    
}

-(void)dismissView
{
    [self removeFromSuperview];
    
}

- (IBAction)okAction:(id)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(didSelectedDate:)]) {
        
        [self.delegate didSelectedDate:_datePicker.date];
        
        
    }
    
    [self dismissView];
    
    
}
@end
