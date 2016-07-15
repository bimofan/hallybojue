//
//  FourVIPCell.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/15.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourVIPCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *vipNameLabel;


@property (weak, nonatomic) IBOutlet UILabel *viptypeLabel;


@property (weak, nonatomic) IBOutlet UILabel *vipNumLabel;


@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

@property (weak, nonatomic) IBOutlet UIView *backView;




@end
