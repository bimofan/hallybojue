//
//  SelectTimeView.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/17.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectTimeViewDelegate <NSObject>

-(void)didSelectedDate:(NSDate*)selectedDate;


@end
@interface SelectTimeView : UIView


@property (nonatomic,assign) id <SelectTimeViewDelegate> delegate;

@property (nonatomic,strong) UIControl *conroll;

@property (nonatomic,strong) NSDate *selectedDate;

@property (weak, nonatomic) IBOutlet UIView *backVie;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *okButton;

- (IBAction)okAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
