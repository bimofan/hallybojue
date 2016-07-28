//
//  PayTypeView.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/16.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "PayTypeView.h"
#import "Constants.h"

@implementation PayTypeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    
    
    UIControl *control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    [control addTarget:self action:@selector(endEdite) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:control];
    
    [self bringSubviewToFront:_backView];
    
    self.backgroundColor = kLighGrayBackColor;
    
    _backView.clipsToBounds = YES;
    _backView.layer.cornerRadius = kCornerRadous;
    
    _onelinePayButton.clipsToBounds = YES;
    _onelinePayButton.layer.cornerRadius = kCornerRadous;
    
    _offlinePayButton.clipsToBounds = YES;
    _offlinePayButton.layer.cornerRadius = kCornerRadous;
    
    _freePayButton.clipsToBounds = YES;
    _freePayButton.layer.cornerRadius = kCornerRadous;
    
    _okButton.clipsToBounds = YES;
    _okButton.layer.cornerRadius = kCornerRadous;
    
    
    _noteTextView.clipsToBounds = YES;
    _noteTextView.layer.cornerRadius = kCornerRadous;
    _noteTextView.layer.borderWidth = 1;
    _noteTextView.layer.borderColor = kLineColor.CGColor;
    _noteTextView.delegate = self;
    
    _cancelButton.clipsToBounds = YES;
    _cancelButton.layer.cornerRadius = kCornerRadous;
    
 
    
    
//     [_onelinePayButton setImage:[UIImage imageNamed:@"jiesuan_xuanz"] forState:UIControlStateNormal];
    
  
    
    
}

-(void)layoutSubviews
{
      [self changebuttonselected];
}


-(void)setPay_type:(NSInteger)pay_type
{
    _pay_type = pay_type;
    
    if (_pay_type == 0 && _pay_type > 3) {
        
        _pay_type = 1;
        
    }
    
  [self changebuttonselected];
    
    
 
}

-(void)changebuttonselected
{
    switch (_pay_type) {
        case 1:
        {
            [_onelinePayButton setImage:[UIImage imageNamed:@"jiesuan_xuanz"] forState:UIControlStateNormal];
            
            [_offlinePayButton setImage:[UIImage imageNamed:@"jiesuan_weixuanz"] forState:UIControlStateNormal];
            
            [_freePayButton setImage:[UIImage imageNamed:@"jiesuan_weixuanz"] forState:UIControlStateNormal];
        }
        break;
        case 2:
        {
            [_onelinePayButton setImage:[UIImage imageNamed:@"jiesuan_weixuanz"] forState:UIControlStateNormal];
            
            [_offlinePayButton setImage:[UIImage imageNamed:@"jiesuan_xuanz"] forState:UIControlStateNormal];
            
            [_freePayButton setImage:[UIImage imageNamed:@"jiesuan_weixuanz"] forState:UIControlStateNormal];
        }
        break;
       case 3:
        {
            [_onelinePayButton setImage:[UIImage imageNamed:@"jiesuan_weixuanz"] forState:UIControlStateNormal];
            
            [_offlinePayButton setImage:[UIImage imageNamed:@"jiesuan_weixuanz"] forState:UIControlStateNormal];
            
            [_freePayButton setImage:[UIImage imageNamed:@"jiesuan_xuanz"] forState:UIControlStateNormal];
        }
        break;
        
        
        default:
        break;
    }
}

- (IBAction)onelinePayAction:(id)sender {
    
 
    
    
    _pay_type = 1;
    
    
    if ([self.delegate respondsToSelector:@selector(didSelectedPayType:)]) {
        
        [self.delegate didSelectedPayType:1];
        
        
    }
    
    [self changebuttonselected];
    
    
    
}
- (IBAction)offlinePayAction:(id)sender {
    
    
      _pay_type = 2;
    
   
    
    if ([self.delegate respondsToSelector:@selector(didSelectedPayType:)]) {
        
        [self.delegate didSelectedPayType:2];
        
        
    }
    
        [self changebuttonselected];
    
    
    
}
- (IBAction)freePayAction:(id)sender {
    
    
     _pay_type = 3;

    
    if ([self.delegate respondsToSelector:@selector(didSelectedPayType:)]) {
        
        [self.delegate didSelectedPayType:3];
        
        
    }
    
        [self changebuttonselected];
    
    
}
- (IBAction)okAction:(id)sender {
    
    [self endEdite];
    
    if ([self.delegate respondsToSelector:@selector(doneSelectedPayType:)]) {
        
        
        NSString *note = _noteTextView.text;
        if (!note) {
            
            note = @"";
        }
        NSDictionary *param = @{@"note":note,@"paytype":@(_pay_type)};
        [self.delegate doneSelectedPayType:param];
        
        
        [self dismiss];
        
        
    }
    
}

-(void)endEdite
{
    [self endEditing:YES];
    
}

-(void)dismiss
{
    
    
    [self removeFromSuperview];
    
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _noteplaceholderLabel.hidden = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
       
        self.center = CGPointMake(self.center.x, self.center.y - 90);
        
        
    }];
    
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (_noteplaceholderLabel.text.length == 0) {
        
        _noteplaceholderLabel.hidden = NO;
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.center = CGPointMake(self.center.x, self.center.y + 90);
        
        
    }];
    
    
    
}
- (IBAction)cancelAction:(id)sender {
    
    [self dismiss];
    
}

-(void)setTotalMoney:(CGFloat)totalMoney
{
    _totalMoney = totalMoney;
    
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",_totalMoney];
    
}
@end
