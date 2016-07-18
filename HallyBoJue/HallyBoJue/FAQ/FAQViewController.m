//
//  FAQViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/18.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "FAQViewController.h"

@interface FAQViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *faqsArray;

@property (nonatomic,strong) NSDictionary *selectedDict;



@end

@implementation FAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _faqsArray = [[NSMutableArray alloc]init];
    
    _FAQTableView.delegate = self;
    _FAQTableView.dataSource = self;
    
    
    _leftView.clipsToBounds = YES;
    _leftView.layer.cornerRadius = kCornerRadous;
    
    
    _rightView.clipsToBounds = YES;
    _rightView.layer.cornerRadius = kCornerRadous;
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_faqsArray.count == 0) {
        
        [self getdata];
        
    }
}

-(void)getdata
{
    [[NetWorking shareNetWorking] RequestWithAction:kKeeperfaq Params:nil itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            
            [_faqsArray removeAllObjects];
            
            DataModel *model = (DataModel*)data;
            
            [_faqsArray addObjectsFromArray:model.items];
            
            
            [_FAQTableView reloadData];
            
        }
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"faqcell"];
    
    NSDictionary *dict = [_faqsArray objectAtIndex:indexPath.section];
    
    UILabel *titleLabel = (UILabel*)[cell viewWithTag:999];
    
    titleLabel.text = [dict objectForKey:@"title"];
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _faqsArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _selectedDict = [_faqsArray objectAtIndex:indexPath.section];
    
    [self setrightview];
    
    
    
    
}


-(void)setrightview
{
    _selectedTitleLabel.text = [_selectedDict objectForKey:@"title"];
    
    NSString *webString = [_selectedDict objectForKey:@"content"];
    
    [_webView loadHTMLString:webString baseURL:nil];
    
}


@end
