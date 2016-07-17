//
//  ChoseWorkPlaceView.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/11.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChoseWorkPlaceDelegate <NSObject>


@required
-(void)didChoseItems:(NSArray*)items;




@end


@interface ChoseWorkPlaceView : UIView<UITableViewDelegate,UITableViewDataSource>

-(void)show;
-(void)dismiss;


@property (nonatomic,assign) NSInteger type ; //显示类型 1 工位选择；  2 技师分派  3 服务建议  4汽车选择
@property (nonatomic,strong) NSArray *hadSeletedItems;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,assign) int store_id;

@property (nonatomic,strong) NSArray *selectedArray;

@property (nonatomic,strong) NSArray *workDataSource;

@property (nonatomic,strong) NSDictionary *selectedDict;


@property (nonatomic,assign) id <ChoseWorkPlaceDelegate> delegate;



@property (weak, nonatomic) IBOutlet UITableView *workTableView;


@property (weak, nonatomic) IBOutlet UIView *backView;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *okButton;


- (IBAction)okAction:(id)sender;


@end
