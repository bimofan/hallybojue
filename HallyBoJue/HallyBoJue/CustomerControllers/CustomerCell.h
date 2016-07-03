//
//  CustomerCell.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/4.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *realnameLabel;


@property (weak, nonatomic) IBOutlet UILabel *carnameLabel;

@property (weak, nonatomic) IBOutlet UILabel *viplabel;

@property (weak, nonatomic) IBOutlet UILabel *lastserviceLabel;

@property (weak, nonatomic) IBOutlet UIButton *addApointButton;

@property (weak, nonatomic) IBOutlet UIButton *servicelistButton;
@property (weak, nonatomic) IBOutlet UIButton *sendMessageButton;

@end
