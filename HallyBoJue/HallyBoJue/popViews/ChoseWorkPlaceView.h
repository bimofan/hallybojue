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

@property (nonatomic,strong) NSArray *hadSeletedItems;
@property (nonatomic,assign) NSInteger selectedIndex;


@property (nonatomic,strong) NSArray *workDataSource;

@property (nonatomic,assign) id <ChoseWorkPlaceDelegate> delegate;



@property (weak, nonatomic) IBOutlet UITableView *workTableView;


@property (weak, nonatomic) IBOutlet UIView *backView;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



@end
