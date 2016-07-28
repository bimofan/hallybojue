//
//  PayTypeView.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/16.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PayTypeDelegate <NSObject>

-(void)didSelectedPayType:(int)payType;

-(void)doneSelectedPayType:(NSDictionary*)dict;



@end


@interface PayTypeView : UIView<UITextViewDelegate>

@property (nonatomic,assign) NSInteger pay_type;

@property (nonatomic,assign) CGFloat totalMoney;

@property (nonatomic,assign) id <PayTypeDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIButton *onelinePayButton;

- (IBAction)onelinePayAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *offlinePayButton;

- (IBAction)offlinePayAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *freePayButton;

- (IBAction)freePayAction:(id)sender;


@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@property (weak, nonatomic) IBOutlet UILabel *noteplaceholderLabel;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

- (IBAction)okAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
- (IBAction)cancelAction:(id)sender;

@end
