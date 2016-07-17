//
//  KeepersortCell.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/17.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeepersortCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *keeperNameLabel;


@property (weak, nonatomic) IBOutlet UILabel *keeperLevelLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;


@end
