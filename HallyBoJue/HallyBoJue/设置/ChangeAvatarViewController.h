//
//  ChangeAvatarViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/20.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangeAvatarViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UIImageView *headImqgeView;

@property (weak, nonatomic) IBOutlet UIButton *changeButton;
- (IBAction)changeAction:(id)sender;

@end
