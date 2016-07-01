//
//  HomeViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/1.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeSlideCell.h"

@interface HomeViewController ()

@property (nonatomic,strong) NSArray *slideTitles;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"哈里伯爵－管家端";
    
}


#

#pragma mark - UITableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeSlideCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeSlideCell"];
    
    
    
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _slideTitles.count;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
